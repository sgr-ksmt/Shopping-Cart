//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Firebase
import KRProgressHUD
import Shared
import UIKit

final class CartViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var purchaseButton: Button! {
        didSet {
            purchaseButton.isEnabled = false
        }
    }

    private var listener: ListenerRegistration?
    private var cartItems: [Document<CartItem>] = [] {
        didSet {
            purchaseButton.isEnabled = !cartItems.isEmpty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cart"
        navigationItem.largeTitleDisplayMode = .always
        tableView.contentInset.bottom = 76
        tableView.scrollIndicatorInsets.bottom = tableView.contentInset.bottom
        tableView.tableFooterView = UIView()
        tableView.register(cellType: CartItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        listenCartItems()

        purchaseButton.addTarget(self, action: #selector(CartViewController.purchase(_:)), for: .touchUpInside)
    }

    func listenCartItems() {
        guard let user = UserManager.shared.currentUser else {
            return
        }

        listener = Document<CartItem>.listen(parentDocument: user) { [weak self] result in
            switch result {
            case let .success(cartItems):
                self?.cartItems = cartItems
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }

    @objc private func purchase(_: UIButton) {
        KRProgressHUD.show()
        PurchaseRequest.call { result in
            KRProgressHUD.dismiss()
            print(result)
        }
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CartItemCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.configure(with: cartItems[indexPath.row])
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "削除") { [weak self] _, _, completionHandler in
            guard let self = self else {
                return
            }
            KRProgressHUD.show()
            let cart = self.cartItems[indexPath.item]
            self.cartItems.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            cart.delete { result in
                KRProgressHUD.dismiss()
                switch result {
                case .success:
                    completionHandler(true)
                case let .failure(error):
                    print(error)
                    completionHandler(false)
                }
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
}
