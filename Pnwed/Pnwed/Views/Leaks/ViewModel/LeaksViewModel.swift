//
//  LeaksViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation

final class LeaksViewModel {
    
    private(set) var recentChecks: [Check] = []
    private(set) var historyChecks: [Check] = []
    
    func fetchCheckData() {
        // Mock data for demonstration
        recentChecks = [
            Check(type: "Password", result: "No leaks found"),
            Check(type: "Account", result: "Compromised in 3 breaches")
        ]
        
        historyChecks = [
            Check(type: "Password", result: "Compromised 2 times"),
            Check(type: "Account", result: "No leaks found")
        ]
    }
}

struct Check {
    let type: String
    let result: String
}

enum CheckType {
    case password
    case account
}
