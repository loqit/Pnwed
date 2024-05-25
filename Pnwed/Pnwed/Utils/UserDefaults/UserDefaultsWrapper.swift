//
//  UserDefaultsWrapper.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation

final class UserDefaultsWrapper {
    
    static let shared = UserDefaultsWrapper()
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    func set<T: UserDefaultsConvertible>(_ value: T, forKey key: UserDefaultsKeys) {
        userDefaults.set(value.userDefaultsValue, forKey: key.rawValue)
    }
    
    func get<T: UserDefaultsConvertible>(forKey key: UserDefaultsKeys, defaultValue: T) -> T {
        guard let value = userDefaults.value(forKey: key.rawValue) else { return defaultValue }
        return T.fromUserDefaultsValue(value) ?? defaultValue
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
    }
}
