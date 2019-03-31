//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static let `default`: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        return f
    }()
}
