//
//  Check.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation

class Check: Codable {
    var type: String
    var placement: String
    var breaches: [Breach]?
    var stringResult: String
    
    init(type: String, placement: String, breaches: [Breach]? = nil, stringResult: String) {
        self.type = type
        self.placement = placement
        self.breaches = breaches
        self.stringResult = stringResult
    }
}
