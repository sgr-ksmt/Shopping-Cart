//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

private let currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.locale = Locale(identifier: "en_US")
    f.numberStyle = .currency
    return f
}()

extension Int {
    public func toPriceString() -> String {
        return currencyFormatter.string(from: self as NSNumber) ?? ""
    }
}
