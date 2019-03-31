//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Shared
import UIKit

final class OrderViewController: UIViewController, StoryboardInstantiatable, Injectable {
    @IBOutlet private weak var orderIDLabel: Label!
    @IBOutlet private weak var purchaseDateLabel: Label!
    @IBOutlet private weak var purchaseQuantityLabel: Label!
    @IBOutlet private weak var tableView: UITableView!

    typealias Dependency = Document<Order>
    private var order: Dependency!

    func inject(_ dependency: Dependency) {
        order = dependency
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Order"

        orderIDLabel.text = order.id
        purchaseDateLabel.text = DateFormatter.default.string(from: order.data.purchaseTime.dateValue())
        purchaseQuantityLabel.text = "\(order.data.snapshotProducts.reduce(into: 0) { $0 += $1.quantity })"
        tableView.reloadData()

        tableView.register(cellType: SnapshotProductCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.data.snapshotProducts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SnapshotProductCell.self, for: indexPath)
        cell.configure(with: order!.data.snapshotProducts[indexPath.row])
        return cell
    }
}

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let productID = order.data.snapshotProducts[indexPath.row].id
        let vc = ProductViewController.instantiate(with: productID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
