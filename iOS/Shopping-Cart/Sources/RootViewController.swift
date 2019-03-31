//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Shared
import UIKit

final class RootViewController: UIViewController {
    enum ViewType {
        case entrance
        case main
    }

    private var viewType: ViewType? {
        didSet {
            guard let type = viewType, oldValue != type else {
                return
            }

            switch type {
            case .entrance: currentViewController = EntranceViewController.instantiate()
            case .main: currentViewController = TabBarController.build()
            }
        }
    }

    private(set) var currentViewController: UIViewController? {
        didSet {
            guard let currentViewController = currentViewController else { return }

            addChild(currentViewController)
            view.addSubview(currentViewController.view)
            currentViewController.didMove(toParent: self)
            currentViewController.view.frame = view.bounds

            guard let oldViewController = oldValue else { return }

            view.sendSubviewToBack(currentViewController.view)
            UIView.transition(from: oldViewController.view, to: currentViewController.view, duration: 0.35, options: .transitionCrossDissolve) { _ in
                oldViewController.willMove(toParent: nil)
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParent()
            }
        }
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.register { [weak self] state in
            switch state {
            case .initial: break
            case .notAuthenticated: self?.viewType = .entrance
            case .authenticated: self?.viewType = .main
            }
        }
    }
}
