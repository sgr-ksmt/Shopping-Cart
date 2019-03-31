//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Shared
import UIKit

final class OrdersViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    private var listener: ListenerRegistration?
    private var orders: [Document<Order>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orders"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(cellType: OrderCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        fetchOrders()
    }

    private func fetchOrders() {
        guard let user = UserManager.shared.currentUser else {
            return
        }
        listener = Document<Order>.listen(parentDocument: user) { [weak self] result in
            switch result {
            case let .success(orders):
                self?.orders = orders
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: OrderCell.self, for: indexPath)
        cell.configure(with: orders[indexPath.row])
        return cell
    }
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let vc = OrderViewController.instantiate(with: orders[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
