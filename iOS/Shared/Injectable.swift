//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

public protocol Injectable {
    associatedtype Dependency = Void
    func inject(_ dependency: Dependency)
}

public extension Injectable where Dependency == Void {
    func inject(_ dependency: Dependency) {
    }
}
