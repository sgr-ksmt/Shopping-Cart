//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

struct CartItem: FirestoreModelReadable, FirestoreModelWritable {
    enum Field: String {
        case product
        case quantity
    }

    static func subCollectionRef(of document: DocumentReference) -> CollectionReference {
        return document.collection("cart_items")
    }

    var product: DocumentReference
    var quantity: Int
    init(snapshot: DocumentSnapshot) {
        quantity = snapshot.intValue(forKey: Field.quantity, default: 0)
        product = snapshot.getValue(forKey: Field.product) ?? Firestore.firestore().collection("").document()
    }

    init(product: DocumentReference, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }

    var writeFields: [Field: Any] {
        return [
            .product: product,
            .quantity: quantity,
        ]
    }
}
