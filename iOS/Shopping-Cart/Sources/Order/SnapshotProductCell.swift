//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Shared
import UIKit

final class SnapshotProductCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var priceLabel: Label!
    @IBOutlet private weak var quantityLabel: Label!
    @IBOutlet private weak var productImageView: UIImageView!

    func configure(with snapshotProduct: SnapshotProduct) {
        nameLabel.text = snapshotProduct.name
        priceLabel.text = snapshotProduct.price.toPriceString()
        quantityLabel.text = "\(snapshotProduct.quantity)"
        productImageView.kf.setImage(with: snapshotProduct.imageURL.asURL())
    }
}
