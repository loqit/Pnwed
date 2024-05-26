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
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Off", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleButtonToggle), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
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
        let isOn = UserDefaultsWrapper.shared.get(forKey: model.userDefaultsKey, defaultValue: false)
        updateButtonState(isOn: isOn, animated: false)
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(toggleButton)
        toggleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    @objc
    private func handleButtonToggle() {
        guard let settingKey else { return }
        let isOn = toggleButton.title(for: .normal) == "Off"
        updateButtonState(isOn: isOn, animated: true)
        UserDefaultsWrapper.shared.set(isOn, forKey: settingKey)
    }
    
    private func updateButtonState(isOn: Bool, animated: Bool) {
        let newTitle = isOn ? "On" : "Off"
        let newColor: UIColor = isOn ? .systemGreen : .systemRed
        
        let updates = {
            self.toggleButton.setTitle(newTitle, for: .normal)
            self.toggleButton.backgroundColor = newColor
        }
        
        if animated {
            UIView.transition(with: toggleButton, 
                              duration: 0.3,
                              options: .transitionCrossDissolve, 
                              animations: updates,
                              completion: nil)
        } else {
            updates()
        }
    }
}
