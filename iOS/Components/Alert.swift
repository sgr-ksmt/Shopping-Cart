//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

public struct Alert {
    public typealias Button = (title: String, style: UIAlertAction.Style, action: () -> Void)
    public static func defaultButton(_ title: String, _ action: @escaping () -> Void = {}) -> Alert.Button {
        return (title, .default, action)
    }

    public static func showSimple(title: String? = nil, message: String? = nil, action: @escaping () -> Void = {}, on viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in action() }))
        viewController.present(alertController, animated: true, completion: nil)
    }

    public static func show(title: String? = nil, message: String? = nil, button: Button, on viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: button.title, style: button.style, handler: { _ in button.action() }))
        viewController.present(alertController, animated: true, completion: nil)
    }

    public static func showWithCancel(title: String? = nil, message: String? = nil, button: Button, cancelButtonTitle: String = "Cancel", on viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: button.title, style: button.style, handler: { _ in button.action() }))
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
