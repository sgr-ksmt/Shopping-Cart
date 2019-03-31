//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

@IBDesignable
public final class Label: UILabel {
    public enum Color: Int {
        case primary
        case secondary
        var color: UIColor {
            switch self {
            case .primary: return UIColor.Text.primary
            case .secondary: return UIColor.Text.secondary
            }
        }
    }

    public var color: Color = .primary {
        didSet {
            update()
        }
    }

    @IBInspectable private var _color: Int = Color.primary.rawValue {
        didSet {
            color = Color(rawValue: _color)!
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }

    private func update() {
        textColor = color.color
    }
}
