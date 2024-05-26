//
//  ViewController.swift
//  Pnwed
//
//  Created by Андрей Бобр on 22.05.24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await getData()
        }
    }

    private func getData() async {
        do {
            let pnwService = PNWService(networkManager: NetworkManager())
            let data = try await pnwService.checkPassword(password: "123456")
            print("🤡", data)
            
            let breaches = try await pnwService.getBreachesData(account: "bobrandrey1972@gmail.com")
            print("🤡 breaches", breaches)
        } catch {
            print(error)
        }
    }
}

