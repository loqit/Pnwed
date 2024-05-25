//
//  PNWService.swift
//  Pnwed
//
//  Created by Андрей Бобр on 22.05.24.
//

import Foundation

final class PNWService {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public
    
    func getBreachesData(account: String) async throws -> [Breach] {
        let url = PNWEndpoint.allBranchesForAccount(account).url
        do {
            let breaches = try await networkManager.get(from: url, type: [Breach].self)
            return breaches
        } catch NetworkError.notFound {
            print("No breaches")
            return []
        } catch {
            print("Something went wrong")
            return []
        }
    }
    
    func checkPassword(password: String) async throws -> Int? {
        let passHash = password.sha1()
        let passHashPrefix = String(passHash.prefix(5))

        let url = PNWEndpoint.searchByRange(passHashPrefix).url
        let hashesString = try await networkManager.getStringData(from: url)
        
        let hashes = parseHashes(hashesString)
        return hashes[String(passHash.dropFirst(5)).uppercased()]
    }
    
    // MARK: - Private
    
    private func parseHashes(_ response: String) -> [String: Int] {
        let lines = response.split(separator: "\r\n")
        var hashCounts: [String: Int] = [:]
        for line in lines {
            let parts = line.split(separator: ":")
            if parts.count == 2, let count = Int(parts[1]) {
                let hash = String(parts[0])
                hashCounts[hash] = count
            }
        }
        
        return hashCounts
    }
}
