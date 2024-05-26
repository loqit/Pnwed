//
//  BreachDetailCell.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import UIKit
import SnapKit

class BreachDetailCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BreachDetailCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let breachDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let addedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let modifiedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let pwnCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(domainLabel)
        domainLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(breachDateLabel)
        breachDateLabel.snp.makeConstraints { make in
            make.top.equalTo(domainLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(addedDateLabel)
        addedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(breachDateLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(modifiedDateLabel)
        modifiedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(addedDateLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(pwnCountLabel)
        pwnCountLabel.snp.makeConstraints { make in
            make.top.equalTo(modifiedDateLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(pwnCountLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with breach: Breach) {
        nameLabel.text = breach.name
        titleLabel.text = breach.title
        domainLabel.text = "Domain: \(breach.domain)"
        breachDateLabel.text = "Breach Date: \(breach.breachDate)"
        addedDateLabel.text = "Added Date: \(breach.addedDate)"
        modifiedDateLabel.text = "Modified Date: \(breach.modifiedDate)"
        pwnCountLabel.text = "Pwn Count: \(breach.pwnCount)"
        descriptionLabel.text = breach.description
    }
}
