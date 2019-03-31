//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
