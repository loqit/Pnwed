//
//  PNWEndpoint.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation

enum PNWEndpoint {
    
    case allBranchesForAccount(String)
    case searchByRange(String)
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(String(describing: self)) is not valid")
        }
        return url
    }
    
    // MARK: - Private
    
    private var fullPath: String {
        switch self {
        case .allBranchesForAccount(let account):
            return "\(ProjectConstants.breachesBaseURL)/breachedaccount/\(account)"
        case .searchByRange(let passHash):
            return "\(ProjectConstants.pasBaseURL)/\(passHash)"
        }
    }
}
