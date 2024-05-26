//
//  LeakCell.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import UIKit

class LeakCell: UITableViewCell {
    
    static let identifier = "LeakCell"
    
    private let checkTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(checkTypeLabel)
        contentView.addSubview(resultLabel)
        
        checkTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTypeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with check: Check) {
        checkTypeLabel.text = check.type
        resultLabel.text = check.stringResult
    }
}
