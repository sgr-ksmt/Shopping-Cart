//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override func loadView() {
        super.loadView()
        navigationBar.prefersLargeTitles = true
    }
}
