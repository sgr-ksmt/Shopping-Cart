//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

struct Product: FirestoreModelReadable, FirestoreModelWritable {
    enum Field: String {
        case name
        case desc
        case imageURL
        case price
        case stock
        case publishedTime
        case owner
    }

    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection("products")
    }

    var name: String
    var desc: String
    var price: Int
    var stock: Int
    var imageURL: String
    var publishedTime: Timestamp
    var owner: DocumentReference

    init(snapshot: DocumentSnapshot) {
        name = snapshot.stringValue(forKey: Field.name, default: "")
        desc = snapshot.stringValue(forKey: Field.desc, default: "")
        imageURL = snapshot.stringValue(forKey: Field.imageURL, default: "")
        price = snapshot.intValue(forKey: Field.price, default: 0)
        stock = snapshot.intValue(forKey: Field.stock, default: 0)
        publishedTime = snapshot.getValue(forKey: Field.publishedTime) ?? Timestamp()
        owner = snapshot.getValue(forKey: Field.owner) ?? Firestore.firestore().collection("").document()
    }

    init(name: String, desc: String, imageURL: String, price: Int, stock: Int, publishedTime: Timestamp = .init(), owner: DocumentReference) {
        self.name = name
        self.desc = desc
        self.imageURL = imageURL
        self.price = price
        self.stock = stock
        self.publishedTime = publishedTime
        self.owner = owner
    }

    var writeFields: [Field: Any] {
        return [
            .name: name,
            .desc: desc,
            .imageURL: imageURL,
            .price: price,
            .stock: stock,
            .publishedTime: publishedTime,
            .owner: owner,
        ]
    }

    static func makeMock(owner: DocumentReference) -> Product {
        let desc = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """
        let mockProducts: [Product] = [
            Product(
                name: "Apple",
                desc: desc,
                imageURL: "https://firebasestorage.googleapis.com/v0/b/shopping-cart-demo-project.appspot.com/o/resources%2Fapple.jpg?alt=media&token=191f5572-db5d-414e-87da-453dcb9ea5b9",
                price: 150,
                stock: 10,
                owner: owner
            ),
            Product(
                name: "Banana",
                desc: desc,
                imageURL: "https://firebasestorage.googleapis.com/v0/b/shopping-cart-demo-project.appspot.com/o/resources%2Fbanana.jpg?alt=media&token=77c2bdea-6c1f-450f-8b4a-0de1fefb1a68",
                price: 120,
                stock: 15,
                owner: owner
            ),
            Product(
                name: "Kiwi",
                desc: desc,
                imageURL: "https://firebasestorage.googleapis.com/v0/b/shopping-cart-demo-project.appspot.com/o/resources%2Fkiwi.jpg?alt=media&token=eb8fd1bf-f254-4424-a1ee-76b598d65c1c",
                price: 160,
                stock: 10,
                owner: owner
            ),
            Product(
                name: "Strawberry",
                desc: desc,
                imageURL: "https://firebasestorage.googleapis.com/v0/b/shopping-cart-demo-project.appspot.com/o/resources%2Fstrawberry.jpg?alt=media&token=53968f5f-163d-4567-ac4e-6ebbdb611c82",
                price: 180,
                stock: 15,
                owner: owner
            ),
        ]
        return mockProducts[Int(arc4random_uniform(UInt32(mockProducts.count)))]
    }
}
