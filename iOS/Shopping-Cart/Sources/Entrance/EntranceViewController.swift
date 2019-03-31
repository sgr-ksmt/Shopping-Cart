//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Components
import Firebase
import KRProgressHUD
import Shared
import UIKit

final class EntranceViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var signUpButton: Button! {
        didSet {
            signUpButton.isEnabled = false
        }
    }

    private var name: String = "" {
        didSet {
            signUpButton.isEnabled = !name.isEmpty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(EntranceViewController.editingChanged), for: .editingChanged)
        signUpButton.addTarget(self, action: #selector(EntranceViewController.signUp), for: .touchUpInside)
    }

    @objc private func editingChanged(_ textField: UITextField) {
        name = textField.text ?? ""
    }

    @objc private func signUp(_: UIButton) {
        KRProgressHUD.show()
        UserManager.shared.signUp(withName: name) { result in
            KRProgressHUD.dismiss()
            print(result)
        }
    }
}

extension EntranceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
