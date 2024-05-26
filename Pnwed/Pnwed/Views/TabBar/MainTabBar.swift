//
//  MainTabBar.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    private func setupTabBar() {
        let adBlockVC = AdBlockerVC()
        
        adBlockVC.tabBarItem = UITabBarItem(title: "AdBlocker", image: UIImage(systemName: "shield"), tag: 0)
        
        let leaksVC = UINavigationController(rootViewController: LeaksVC())
        leaksVC.tabBarItem = UITabBarItem(title: "Leaks", image: UIImage(systemName: "exclamationmark.triangle"), tag: 1)
        
        viewControllers = [adBlockVC, leaksVC]
    }
}
