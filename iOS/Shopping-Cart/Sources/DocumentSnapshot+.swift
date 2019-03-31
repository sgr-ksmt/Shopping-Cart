//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Firebase
import Foundation

extension DocumentSnapshot {
    func getValue<V>(forKey key: String) -> V? {
        return data()?[key] as? V
    }

    func getValue<V>(forKey key: String, default: V) -> V {
        return getValue(forKey: key) ?? `default`
    }

    func stringValue(forKey key: String) -> String? {
        return getValue(forKey: key)
    }

    func stringValue(forKey key: String, default: String) -> String {
        return getValue(forKey: key, default: `default`)
    }

    func intValue(forKey key: String) -> Int? {
        return getValue(forKey: key)
    }

    func intValue(forKey key: String, default: Int) -> Int {
        return getValue(forKey: key, default: `default`)
    }

    func getValue<K: RawRepresentable, V>(forKey key: K) -> V? where K.RawValue == String {
        return getValue(forKey: key.rawValue)
    }

    func getValue<K: RawRepresentable, V>(forKey key: K, default: V) -> V where K.RawValue == String {
        return getValue(forKey: key.rawValue, default: `default`)
    }

    func stringValue<K: RawRepresentable>(forKey key: K) -> String? where K.RawValue == String {
        return stringValue(forKey: key.rawValue)
    }

    func stringValue<K: RawRepresentable>(forKey key: K, default: String) -> String where K.RawValue == String {
        return stringValue(forKey: key.rawValue, default: `default`)
    }

    func intValue<K: RawRepresentable>(forKey key: K) -> Int? where K.RawValue == String {
        return intValue(forKey: key.rawValue)
    }

    func intValue<K: RawRepresentable>(forKey key: K, default: Int) -> Int where K.RawValue == String {
        return intValue(forKey: key.rawValue, default: `default`)
    }
}
