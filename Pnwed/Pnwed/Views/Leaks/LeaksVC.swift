//
//  LeaksVC.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import UIKit

class LeaksVC: UIViewController {
    
    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Recent Checks", "History"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let leaksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LeakCell.self, forCellReuseIdentifier: LeakCell.identifier)
        return tableView
    }()
    
    private let viewModel = LeaksViewModel()
    private var selectedSegmentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupSegmentedControl()
        setupTableView()
        
        viewModel.fetchCheckData()
        leaksTableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "Leaks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddMenu))
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setupTableView() {
        leaksTableView.dataSource = self
        leaksTableView.delegate = self
        view.addSubview(leaksTableView)
        
        leaksTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func segmentChanged() {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        leaksTableView.reloadData()
    }
    
    @objc private func showAddMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Check Password", style: .default, handler: { _ in
            self.presentCheckModal(for: .password)
        }))
        alert.addAction(UIAlertAction(title: "Check Account", style: .default, handler: { _ in
            self.presentCheckModal(for: .account)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentCheckModal(for checkType: CheckType) {
        let checkVC = ModalCheckVC(checkType: checkType)
       // let navController = UINavigationController(rootViewController: checkVC)
        present(checkVC, animated: true, completion: nil)
    }
}

extension LeaksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return selectedSegmentIndex == 0 ? viewModel.recentChecks.count : viewModel.historyChecks.count
    }

    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeakCell.identifier, for: indexPath) as? LeakCell else {
            return UITableViewCell()
        }
        let check = selectedSegmentIndex == 0 ? viewModel.recentChecks[indexPath.row] : viewModel.historyChecks[indexPath.row]
        cell.configure(with: check)
        return cell
    }
}
