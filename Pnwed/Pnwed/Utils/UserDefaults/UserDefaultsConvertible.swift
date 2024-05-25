//
//  UserDefaultsConvertible.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation

protocol UserDefaultsConvertible {
    var userDefaultsValue: Any { get }
    static func fromUserDefaultsValue(_ value: Any) -> Self?
}

extension String: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> String? { value as? String }
}

extension Int: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> Int? { value as? Int }
}

extension Double: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> Double? { value as? Double }
}

extension Bool: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> Bool? { value as? Bool }
}

extension Date: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> Date? { value as? Date }
}

extension Data: UserDefaultsConvertible {
    var userDefaultsValue: Any { self }
    static func fromUserDefaultsValue(_ value: Any) -> Data? { value as? Data }
}
