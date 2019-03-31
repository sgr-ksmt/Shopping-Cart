//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

@IBDesignable
public final class RoundedView: UIView {
    @IBInspectable public private(set) var cornerRadius: CGFloat = 8.0 {
        didSet {
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
        layer.masksToBounds = true
    }

    private func update() {
        layer.cornerRadius = cornerRadius
    }
}
