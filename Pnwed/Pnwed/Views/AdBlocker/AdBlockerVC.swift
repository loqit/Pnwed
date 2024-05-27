//
//  AdBlockerVC.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import UIKit
import Combine

class AdBlockerVC: UIViewController {
    
    // MARK: - Properties
    
    private let settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        return tableView
    }()
    
    private lazy var premiumButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Premium".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePremiumButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemOrange
        button.isHidden = UserDefaultsWrapper.shared.get(forKey: .isPremium, defaultValue: false)
        return button
    }()
    
    private let viewModel: AdBlockerViewModel = AdBlockerViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .white
        setupConstraints()
        setupTableView()
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(400)
        }
                
        view.addSubview(premiumButton)
        premiumButton.snp.makeConstraints { make in
            make.top.equalTo(settingsTableView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(35)
        }
    }
    
    private func setupTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @objc
    private func handlePremiumButton() {
        let paywallVC = PaywallVC()
        paywallVC.setPremium
            .sink { [weak self] in
                guard let self else { return }
                self.premiumButton.isHidden = true
            }
            .store(in: &subscriptions)
        self.present(paywallVC, animated: true)
    }
}

extension AdBlockerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, 
                                                       for: indexPath) as? SwitchCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(from: viewModel.settings[indexPath.row])
        return cell
    }
}
