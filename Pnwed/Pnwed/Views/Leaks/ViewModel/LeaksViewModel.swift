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
        guard let decodedData = getChecks() else { return }
        recentChecks = decodedData.filter { $0.placement == "recentChecks" }.reversed()
        historyChecks = decodedData.filter { $0.placement == "history" }.reversed()
    }
    
    func deleteCheck(by id: UUID) {
        guard let decodedData = getChecks() else { return }
        
        let history = decodedData.filter { $0.id != id }
        historyChecks = historyChecks.filter { $0.id != id }
        if let encodedData = try? PropertyListEncoder().encode(history) {
            UserDefaultsWrapper.shared.set(encodedData, forKey: .checks)
        }
    }
    
    private func getChecks() -> [Check]? {
        let checksString: Data = UserDefaultsWrapper.shared.get(forKey: .checks, defaultValue: Data())
        guard let decodedData = try? PropertyListDecoder().decode([Check].self, from: checksString) else {
            return nil
        }
        return decodedData
    }
}

enum CheckType {
    case password
    case account
}
