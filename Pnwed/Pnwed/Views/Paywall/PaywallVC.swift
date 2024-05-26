//
//  PaywallVC.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import UIKit
import SnapKit
import Adapty

class PaywallVC: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Your Plan"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var yearlyButton: PaywallButton = {
        let view = PaywallButton(product: products.first, type: .yearly)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yearlyAction)))
        return view
    }()
    
    private lazy var monthlyButton: PaywallButton = {
        let view = PaywallButton(product: products.last, type: .weekly)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(monthlyAction)))
        return view
    }()
    
    private let weeklyPerDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let yearlyPerDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var products: [AdaptyPaywallProduct] = [AdaptyPaywallProduct]()
    private lazy var selectedProduct = products.first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupConstraints()
        fetchSubscriptionDetails()
    }
    
    private func setupConstraints() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(monthlyButton)
        monthlyButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(60)
        }
        
        view.addSubview(yearlyButton)
        yearlyButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(monthlyButton.snp.bottom).offset(4)
            make.height.equalTo(60)
        }
        
        view.addSubview(weeklyPerDayLabel)
        weeklyPerDayLabel.snp.makeConstraints { make in
            make.top.equalTo(weeklyPerDayLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(yearlyPerDayLabel)
        yearlyPerDayLabel.snp.makeConstraints { make in
            make.top.equalTo(yearlyButton.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    @objc func yearlyAction() {
        yearlyButton.animateTap()
        monthlyButton.deselectTap()
        selectedProduct = products.first
    }
    
    @objc func monthlyAction() {
        monthlyButton.animateTap()
        yearlyButton.deselectTap()
        selectedProduct = products.last
    }
    
    private func fetchSubscriptionDetails() {
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
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func continueButtonTapped() {
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
}
