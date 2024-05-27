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
        let view = PaywallButton(product: viewModel.products.first, type: .yearly)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yearlyAction)))
        return view
    }()
    
    private lazy var weeklyButton: PaywallButton = {
        let view = PaywallButton(product: viewModel.products.last, type: .weekly)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(weeklyAction)))
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
    
    private let viewModel = PaywallViewModel()
    
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
        
        view.addSubview(weeklyButton)
        weeklyButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(60)
        }
        
        view.addSubview(yearlyButton)
        yearlyButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(v.snp.bottom).offset(4)
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
        weeklyButton.deselectTap()
        viewModel.selectedProduct = viewModel.products.first
    }
    
    @objc func weeklyAction() {
        weeklyButton.animateTap()
        yearlyButton.deselectTap()
        viewModel.selectedProduct = viewModel.products.last
    }
    
    private func fetchSubscriptionDetails() {
        viewModel.fetchSubscriptionDetails()
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func continueButtonTapped() {
        viewModel.purchase()
    }
}
