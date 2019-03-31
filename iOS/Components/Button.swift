//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

@IBDesignable
public final class Button: UIButton {
    public enum Theme: Int {
        case main

        var textColor: UIColor {
            switch self {
            case .main: return UIColor.Text.primary
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .main: return UIColor.App.main
            }
        }

        var disabledBackgroundColor: UIColor {
            switch self {
            case .main: return UIColor.Background.disabled
            }
        }
    }

    public var theme: Theme = .main {
        didSet {
            update()
        }
    }

    @IBInspectable private var _theme: Int = Theme.main.rawValue {
        didSet {
            theme = Theme(rawValue: _theme)!
        }
    }

    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            update()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        update()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        update()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }

    private func setup() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }

    private func update() {
        setTitleColor(theme.textColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        if isEnabled {
            backgroundColor = UIColor.App.main
        } else {
            backgroundColor = UIColor.Background.disabled
        }
    }
}
