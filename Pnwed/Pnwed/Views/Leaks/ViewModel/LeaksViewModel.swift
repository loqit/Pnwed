//
//  LeaksViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation

@MainActor
final class LeaksViewModel {
    
    private(set) var recentChecks: [Check] = []
    private(set) var historyChecks: [Check] = []
    
    func fetchChecks() {
        let checksString: Data = UserDefaultsWrapper.shared.get(forKey: .checks, defaultValue: Data())
        guard let decodedData = try? PropertyListDecoder().decode([Check].self, from: checksString) else {
            return
        }
        recentChecks = decodedData.filter { $0.placement == "recentChecks" }.reversed()
        historyChecks = decodedData.filter { $0.placement == "history" }.reversed()
    }
    
    func deleteCheck(by id: UUID) {
        let checksString: Data = UserDefaultsWrapper.shared.get(forKey: .checks, defaultValue: Data())
        guard let decodedData = try? PropertyListDecoder().decode([Check].self, from: checksString) else {
            return
        }
        
        let history = decodedData.filter { $0.id != id }
        historyChecks = historyChecks.filter { $0.id != id }
        if let encodedData = try? PropertyListEncoder().encode(history) {
            UserDefaultsWrapper.shared.set(encodedData, forKey: .checks)
        }
    }
}

enum CheckType {
    case password
    case account
}
