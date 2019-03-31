//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Shared
import UIKit

final class CartItemCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var priceLabel: Label!
    @IBOutlet private weak var quantityLabel: Label!
    @IBOutlet private weak var productImageView: RoundedImageView!

    func configure(with cartItem: Document<CartItem>) {
        quantityLabel.text = "\(cartItem.data.quantity)"
        Document<Product>.get(documentID: cartItem.data.product.documentID) { [weak self] result in
            let product = try? result.get()
            self?.nameLabel.text = product?.data.name ?? ""
            self?.priceLabel.text = product.map { $0.data.price.toPriceString() } ?? ""
            self?.productImageView.kf.setImage(with: product?.data.imageURL.asURL())
        }
    }
}
