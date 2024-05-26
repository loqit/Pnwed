//
//  ModalCheckViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation

@MainActor
final class ModalCheckViewModel {
    
    private let pnwService = PNWService(networkManager: NetworkManager())
    
    func checkPassword(password: String) async throws -> Int? {
        let result = try await pnwService.checkPassword(password: password)
        return result
    }
    
    func checkAccount(account: String) async throws -> [Breach] {
        let result = try await pnwService.getBreachesData(account: account)
        return result
    }
}
