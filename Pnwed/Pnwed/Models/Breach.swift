//
//  Breach.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation
import SwiftData

struct Breach: Codable {
    let name: String
    let title: String
    let domain: String
    let breachDate: String
    let addedDate: String
    let modifiedDate: String
    let pwnCount: Int
    let description: String
    let dataClasses: [String]
    let isVerified: Bool
    let isFabricated: Bool
    let isSensitive: Bool
    let isRetired: Bool
    let isSpamList: Bool
    let logoPath: String?
}
