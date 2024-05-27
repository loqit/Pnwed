//
//  ModalCheckViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation

@MainActor
final class ModalCheckViewModel {
    
    // MARK: - Properties
    
    private let pnwService = PNWService(networkManager: NetworkManager())
    private(set) var breaches: [Breach] = []
    
    // MARK: - Public
    
    func checkPassword(password: String) async throws -> Int? {
        let result = try await pnwService.checkPassword(password: password)
        return result
    }
    
    func checkAccount(account: String) async throws -> [Breach] {
       // let result = try await pnwService.getBreachesData(account: account)
        breaches = generateMockBreaches(count: 3)
        return breaches
    }
    
    func saveCheck(check: Check, recentCheck: Bool = false) {
        let checksString: Data = UserDefaultsWrapper.shared.get(forKey: .checks, defaultValue: Data())
        var decodedData = (try? PropertyListDecoder().decode([Check].self, from: checksString)) ?? []
        decodedData.append(check)
        let recentData = decodedData.filter { $0.placement == "recentChecks" }
        if recentCheck && recentData.count > 2 {
            if let index = decodedData.firstIndex(where: { $0.placement == "recentChecks" }) {
                decodedData.remove(at: index)
            }
        }
        if let encodedData = try? PropertyListEncoder().encode(decodedData) {
            UserDefaultsWrapper.shared.set(encodedData, forKey: .checks)
        }
    }
    
    // MARK: - Private
    
    // It seems that api key is invalid (401 status code). So I generate mock data to imitate it
    private func generateMockBreaches(count: Int) -> [Breach] {
        var breaches = [Breach]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for _ in 0..<count {
            let name = "Mock Breach"
            let title = "Mock Title"
            let domain = "example.com"
            let breachDate = dateFormatter.string(from: Date())
            let addedDate = dateFormatter.string(from: Date())
            let modifiedDate = dateFormatter.string(from: Date())
            let pwnCount = Int.random(in: 1...1000)
            let description = "Mock Description"
            let dataClasses = ["Password", "Email"]
            let isVerified = Bool.random()
            let isFabricated = Bool.random()
            let isSensitive = Bool.random()
            let isRetired = Bool.random()
            let isSpamList = Bool.random()
            let logoPath: String? = nil
            
            let breach = Breach(name: name,
                                title: title,
                                domain: domain,
                                breachDate: breachDate,
                                addedDate: addedDate,
                                modifiedDate: modifiedDate,
                                pwnCount: pwnCount,
                                description: description,
                                dataClasses: dataClasses,
                                isVerified: isVerified,
                                isFabricated: isFabricated,
                                isSensitive: isSensitive,
                                isRetired: isRetired,
                                isSpamList: isSpamList,
                                logoPath: logoPath)
            
            breaches.append(breach)
        }
        
        return breaches
    }
}
