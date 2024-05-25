//
//  AdBlockerViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import Foundation

final class AdBlockerViewModel {
    
    private(set) var settings: [SwitchCellModel] = [
        .init(title: "Enable Tracking", userDefaultsKey: .enableTracking),
        .init(title: "Enable Ads", userDefaultsKey: .enableAds),
        .init(title: "Enable Pushes", userDefaultsKey: .enablePushes)
    ]
}
