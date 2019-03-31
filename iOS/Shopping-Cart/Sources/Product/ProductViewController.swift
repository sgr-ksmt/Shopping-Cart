//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Firebase
import KRProgressHUD
import Shared
import UIKit

final class ProductViewController: UIViewController, StoryboardInstantiatable, Injectable {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var addToCartButton: Button!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var descriptionLabel: Label!
    @IBOutlet private weak var priceLabel: Label!
    @IBOutlet private weak var stockLabel: Label!
    @IBOutlet private weak var imageView: UIImageView!

    typealias Dependency = String
    private var productID: String!
    private var product: Document<Product>?
    private var listener: ListenerRegistration?

    func inject(_ dependency: Dependency) {
        productID = dependency
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product"

        listener = Document<Product>.listen(documentID: productID) { [weak self] result in
            switch result {
            case let .success(product):
                self?.product = product
                self?.addToCartButton.isEnabled = product?.data.stock ?? 0 > 0
                self?.nameLabel.text = product?.data.name
                self?.descriptionLabel.text = product?.data.desc
                self?.priceLabel.text = product.map { $0.data.price.toPriceString() }
                self?.stockLabel.text = product.map { $0.data.stock > 0 ? "\($0.data.stock) left in stock" : "Out of stock." }
                self?.imageView.kf.setImage(with: product?.data.imageURL.asURL())
            case let .failure(error):
                print(error)
            }
        }

        addToCartButton.addTarget(self, action: #selector(ProductViewController.addToCart(_:)), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func addToCart(_: Button) {
        guard let user = UserManager.shared.currentUser else {
            return
        }
        guard let product = product else {
            return
        }
        KRProgressHUD.show()
        Document<CartItem>.get(parentDocument: user, queryBuilder: { q in q.whereField("product", isEqualTo: product.ref).limit(to: 1) }) { result in
            KRProgressHUD.dismiss()
            switch result {
            case let .success(cartItems):
                if let existsCartItem = cartItems.first {
                    existsCartItem.update(fields: [.quantity: FieldValue.increment(Int64(1))]) { result in
                        print(result)
                    }
                } else {
                    let cartItem = CartItem(product: product.ref, quantity: 1)
                    Document<CartItem>.create(parentDocument: user, model: cartItem) { result in
                        print(result)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
