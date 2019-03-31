//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

public extension String {
    func asURL() -> URL? {
        if isEmpty {
            return nil
        }
        return URL(string: self)
    }
}
