//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import UIKit

private class C: NSObject {}

public extension UIColor {
    struct App {
        public static let main = UIColor(named: "app", in: Bundle(for: C.self), compatibleWith: nil)!
    }

    struct Text {
        public static let primary = UIColor(named: "text/primary", in: Bundle(for: C.self), compatibleWith: nil)!
        public static let secondary = UIColor(named: "text/secondary", in: Bundle(for: C.self), compatibleWith: nil)!
    }

    struct Background {
        public static let gray = UIColor(named: "background/gray", in: Bundle(for: C.self), compatibleWith: nil)!
        public static let disabled = UIColor(named: "background/disabled", in: Bundle(for: C.self), compatibleWith: nil)!
    }
}
