//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Shared
import UIKit

final class TabBarController: UITabBarController {
    static func build() -> TabBarController {
        let tabBarController = TabBarController()

        let productViewController = ProductsViewController.instantiate()
        productViewController.title = "products"

        let cartViewController = CartViewController.instantiate()
        cartViewController.title = "Cart"

        let orderViewController = OrdersViewController.instantiate()
        orderViewController.title = "Orders"

        let userViewcontroller = UserViewController.instantiate()
        userViewcontroller.title = UserManager.shared.currentUser?.data.name ?? ""
        tabBarController.setViewControllers(
            [
                NavigationController(rootViewController: productViewController),
                NavigationController(rootViewController: cartViewController),
                NavigationController(rootViewController: orderViewController),
                userViewcontroller,
            ],
            animated: false
        )
        return tabBarController
    }
}
