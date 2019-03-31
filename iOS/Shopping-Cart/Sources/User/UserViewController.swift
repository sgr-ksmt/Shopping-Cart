//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Shared
import UIKit

final class UserViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var signOutButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = UserManager.shared.currentUser?.data.name ?? ""
        nameLabel.text = "Hi, \(name)"
        signOutButton.addTarget(self, action: #selector(UserViewController.signOut), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func signOut(_: UIButton) {
        Alert.showWithCancel(
            title: "Confirm",
            message: "Do you want to sign out?",
            button: ("Sign Out", .destructive, { UserManager.shared.signOut() }),
            on: self
        )
    }
}
