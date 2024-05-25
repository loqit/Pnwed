//
//  NetworkManagerProtocol.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func get<T: Decodable>(from url: URL, type: T.Type) async throws -> T
    func getStringData(from url: URL) async throws -> String
}
