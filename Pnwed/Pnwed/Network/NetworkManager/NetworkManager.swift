//
//  NetworkManager.swift
//  Pnwed
//
//  Created by Андрей Бобр on 22.05.24.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    
    // MARK: - Init
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Public
    
    func get<T: Decodable>(from url: URL, type: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.addValue("hibp-api-key: \(ProjectConstants.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let (data, response) = try await urlSession.data(for: request)
        print("🤡", response)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            if (response as? HTTPURLResponse)?.statusCode == 404 {
                throw NetworkError.notFound
            } else {
                throw NetworkError.invalidResponse
            }
        }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    func getStringData(from url: URL) async throws -> String {
        let (data, response) = try await urlSession.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw NetworkError.noData
        }
        return responseString
    }
}
