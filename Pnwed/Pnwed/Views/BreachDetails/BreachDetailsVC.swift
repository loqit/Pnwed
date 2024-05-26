//
//  BreachDetailsVC.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import UIKit
import SnapKit

class BreachDetailVC: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BreachDetailCell.self, forCellReuseIdentifier: BreachDetailCell.identifier)
        return tableView
    }()
    
    private let breaches: [Breach]
    
    // MARK: - Init
    
    init(breaches: [Breach]) {
        self.breaches = breaches
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Breach Details"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension BreachDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return breaches.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreachDetailCell.identifier, 
                                                       for: indexPath) as? BreachDetailCell else {
            return UITableViewCell()
        }
        let breach = breaches[indexPath.row]
        cell.configure(with: breach)
        return cell
    }
}
