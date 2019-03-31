//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

struct PurchaseRequest {
    struct Response: Decodable {
        var orderID: String
    }

    static func call(completion: @escaping (Result<Response, Error>) -> Void) {
        Functions.functions(region: "asia-northeast1").httpsCallable("purchase").call { result, error in
            switch Result(result, error) {
            case let .success(result):
                if let orderID = (result.data as? [String: String])?["orderID"] {
                    completion(.success(.init(orderID: orderID)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
