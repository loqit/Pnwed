//
//  PaywallViewModel.swift
//  Pnwed
//
//  Created by Андрей Бобр on 27.05.24.
//

import Foundation
import Adapty

final class PaywallViewModel {
    
    private(set) var products: [AdaptyPaywallProduct] = [AdaptyPaywallProduct]()
    lazy var selectedProduct = products.first
    
    func purchase() {
        guard let selectedProduct else { return }
        Adapty.makePurchase(product: selectedProduct) { result in
            switch result {
            case .success(let purchaseInfo):
                print("Successful purchase : \(purchaseInfo)")
            case .failure(let error):
                print("Purchase error: \(error)")
            }
        }
    }
    
    func fetchSubscriptionDetails() {
        Adapty.getPaywall(placementId: "adblocker") { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let paywall):
                self.getProducts(from: paywall)
            case .failure(let error):
                print("Paywall error \(error)")
            }
        }
    }
    
    private func getProducts(from paywall: AdaptyPaywall) {
        Adapty.getPaywallProducts(paywall: paywall) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print("Error fetching products \(error)")
            }
        }
    }
}
