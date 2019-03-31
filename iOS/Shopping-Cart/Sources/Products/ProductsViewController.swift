//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import KRProgressHUD
import Shared
import UIKit

final class ProductsViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    private var listener: ListenerRegistration?
    private var products: [Document<Product>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ProductsViewController.addProductRandomly))
        navigationItem.rightBarButtonItem = addBarButtonItem

        tableView.register(cellType: ProductCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        fetchProducts()
    }

    private func fetchProducts() {
        listener = Document<Product>
            .listen(queryBuilder: { query in query.order(by: "publishedTime", descending: true).limit(to: 100) })
            { [weak self] result in
                switch result {
                case let .success(products):
                    self?.products = products
                    self?.tableView.reloadData()
                case let .failure(error):
                    print(error)
                }
        }
    }

    @objc private func addProductRandomly() {
        guard let userRef = UserManager.shared.currentUser?.ref else {
            fatalError("Owner must be non nil")
        }
        let product = Product.makeMock(owner: userRef)
        KRProgressHUD.show()
        Document<Product>.create(model: product) { result in
            KRProgressHUD.dismiss()
            print(result)
        }
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
        cell.configure(with: products[indexPath.row].data)
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let productID = products[indexPath.item].id
        let vc = ProductViewController.instantiate(with: productID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
