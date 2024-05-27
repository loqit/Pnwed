//
//  String+Extension.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation
import CommonCrypto

extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        
        let hexString = digest.map { String(format: "%02hhx", $0) }.joined()
        return hexString
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}
