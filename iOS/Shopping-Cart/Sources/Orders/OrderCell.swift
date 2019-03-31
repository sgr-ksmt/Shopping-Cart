//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Shared
import UIKit

final class OrderCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var orderIDLabel: Label!
    @IBOutlet private weak var purchaseDateLabel: Label!
    @IBOutlet private weak var purchaseQuantityLabel: Label!
    @IBOutlet private weak var amountLabel: Label!

    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    func configure(with order: Document<Order>) {
        orderIDLabel.text = order.id
        purchaseDateLabel.text = DateFormatter.default.string(from: order.data.purchaseTime.dateValue())
        purchaseQuantityLabel.text = "\(order.data.totalQuantity)"
        amountLabel.text = "\(order.data.amount)"
    }
}
