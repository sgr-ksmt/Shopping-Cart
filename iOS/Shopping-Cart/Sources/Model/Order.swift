//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

struct SnapshotProduct {
    struct Field {
        static let id = "id"
        static let name = "name"
        static let desc = "desc"
        static let price = "price"
        static let quantity = "quantity"
        static let imageURL = "imageURL"
        static let owner = "owner"
    }

    let id: String
    let name: String
    let desc: String
    let price: Int
    let quantity: Int
    let imageURL: String
    let owner: DocumentReference

    init(json: [String: Any]) {
        id = (json[Field.id] as? String) ?? ""
        name = (json[Field.name] as? String) ?? ""
        desc = (json[Field.desc] as? String) ?? ""
        price = (json[Field.price] as? Int) ?? 0
        quantity = (json[Field.quantity] as? Int) ?? 0
        imageURL = (json[Field.imageURL] as? String) ?? ""
        owner = (json[Field.owner] as? DocumentReference) ?? Firestore.firestore().document("")
    }
}

struct Order: FirestoreModelReadable {
    enum Field: String {
        case purchaseTime
        case snapshotProducts
    }

    static func subCollectionRef(of document: DocumentReference) -> CollectionReference {
        return document.collection("orders")
    }

    let purchaseTime: Timestamp
    let snapshotProducts: [SnapshotProduct]

    init(snapshot: DocumentSnapshot) {
        purchaseTime = snapshot.getValue(forKey: Field.purchaseTime) ?? Timestamp()
        let jsonArray: [[String: Any]] = snapshot.getValue(forKey: Field.snapshotProducts) ?? []
        snapshotProducts = jsonArray.map(SnapshotProduct.init(json:))
    }

    var totalQuantity: Int {
        return snapshotProducts.reduce(into: 0) { $0 += $1.quantity }
    }

    var amount: Int {
        return snapshotProducts.reduce(into: 0) { $0 += $1.price }
    }
}
