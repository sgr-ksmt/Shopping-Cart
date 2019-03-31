//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Kingfisher
import Shared
import UIKit

final class ProductCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var priceLabel: Label!
    @IBOutlet private weak var stockLabel: Label!
    @IBOutlet private weak var productImageView: RoundedImageView!

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = product.price.toPriceString()
        stockLabel.text = "\(product.stock)"
        productImageView.kf.setImage(with: product.imageURL.asURL())
    }
}
