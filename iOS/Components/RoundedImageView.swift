//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

@IBDesignable
public final class RoundedImageView: UIImageView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        backgroundColor = UIColor.Background.gray
    }
}
