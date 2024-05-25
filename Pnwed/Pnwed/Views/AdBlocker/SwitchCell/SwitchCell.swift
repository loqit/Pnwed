//
//  SwitchCell.swift
//  Pnwed
//
//  Created by Андрей Бобр on 25.05.24.
//

import UIKit
import SnapKit

class SwitchCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SwitchCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.translatesAutoresizingMaskIntoConstraints = false
        cellSwitch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        return cellSwitch
    }()
    
    private var settingKey: UserDefaultsKeys?
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    func setupCell(from model: SwitchCellModel) {
        title.text = model.title
        settingKey = model.userDefaultsKey
        cellSwitch.isOn = UserDefaultsWrapper.shared.get(forKey: model.userDefaultsKey, defaultValue: false)
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(cellSwitch)
        cellSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    // TODO: - Test it again
    @objc
    private func handleSwitch() {
        guard let settingKey else { return }
        UserDefaultsWrapper.shared.set(cellSwitch.isOn, forKey: settingKey)
    }
}
