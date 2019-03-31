//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

final class UserManager {
    enum State {
        case initial
        case notAuthenticated
        case authenticated(Document<User>)
    }

    static let shared = UserManager()
    private var handle: AuthStateDidChangeListenerHandle?
    private var listeners: [(State) -> Void] = []
    private(set) var currentState: State = .initial {
        didSet {
            listeners.forEach { $0(currentState) }
        }
    }

    var currentUser: Document<User>? {
        switch currentState {
        case .initial: return nil
        case .notAuthenticated: return nil
        case let .authenticated(user): return user
        }
    }

    private init() {
        handle = Auth.auth().addStateDidChangeListener { [unowned self] _, user in
            self.fetch(authUser: user)
        }
    }

    private func fetch(authUser: Firebase.User? = Auth.auth().currentUser) {
        guard let authUser = authUser else {
            currentState = .notAuthenticated
            return
        }

        Document<User>.get(documentID: authUser.uid) { result in
            switch result {
            case let .success(user):
                if let user = user {
                    self.currentState = .authenticated(user)
                } else {
                    self.currentState = .notAuthenticated
                }
            case let .failure(error):
                print(error)
                self.currentState = .notAuthenticated
            }
        }
    }

    func register(listener: @escaping (State) -> Void) {
        listeners.append(listener)
        listener(currentState)
    }

    func signUp(withName name: String, completion: @escaping (Result<(), Error>) -> Void) {
        if Auth.auth().currentUser != nil {
            return
        }

        Auth.auth().signInAnonymously { authDataResult, error in
            switch Result(authDataResult, error) {
            case let .success(authDataResult):
                Document<User>.create(documentID: authDataResult.user.uid, model: .init(name: name)) { result in
                    switch result {
                    case .success:
                        completion(.success(()))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
    }
}
