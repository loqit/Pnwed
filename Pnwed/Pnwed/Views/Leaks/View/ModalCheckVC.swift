//
//  ModalCheckVC.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import UIKit
import SnapKit
import Combine

class ModalCheckVC: UIViewController {
    
    // MARK: - Properties
    
    private let inputLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check", for: .normal)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.setTitle("Save Response", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let checkType: CheckType
    private let viewModel = ModalCheckViewModel()
    
    var checkSaved = PassthroughSubject<Void, Never>()
    
    // MARK: - Init
    
    init(checkType: CheckType) {
        self.checkType = checkType
        
        super.init(nibName: nil, bundle: nil)
        
        inputTextField.isSecureTextEntry = checkType == .password
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        title = checkType == .password ? "Check Password" : "Check Account"
        
        inputLabel.text = checkType == .password ? "Enter Password" : "Enter Account"
        
        view.addSubview(inputLabel)
        inputLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(inputLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        inputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        checkButton.isEnabled = !(inputTextField.text?.isEmpty ?? true)
        checkButton.backgroundColor = (inputTextField.text?.isEmpty ?? true) ? .lightGray : .systemRed
        saveButton.isEnabled = false
        saveButton.backgroundColor = .lightGray
    }
    
    @objc private func checkButtonTapped() {
        guard let input = inputTextField.text, !input.isEmpty else {
            resultLabel.text = "Please enter a valid \(checkType == .password ? "password" : "account")"
            return
        }
        
        activityIndicator.startAnimating()
        checkButton.isEnabled = false
        checkButton.backgroundColor = .lightGray
        performCheck(for: input)
    }
    
    @objc private func addButtonPressed() {
        viewModel.saveCheck(check: .init(type: checkType == .account ? "Account Check: \(inputTextField.text ?? "")" : "Password Check",
                                         placement: "history",
                                         breaches: viewModel.breaches,
                                         stringResult: resultLabel.text ?? ""))
        checkSaved.send()
    }
    
    private func performCheck(for input: String) {
         Task {
             do {
                 switch checkType {
                 case .password:
                     try await checkPassword(password: input)
                 case .account:
                     try await checkAccount(account: input)
                 }
                 saveButton.isEnabled = true
                 saveButton.backgroundColor = .systemGreen
             } catch {
                 resultLabel.text = "Something went wrong. Please, try again!"
                 resultLabel.textColor = .red
             }
             DispatchQueue.main.async { [weak self] in
                 guard let self else { return }
                 self.activityIndicator.stopAnimating()
                 self.checkButton.isEnabled = true
                 self.checkButton.backgroundColor = .systemRed
             }
         }
     }
     
     private func checkPassword(password: String) async throws {
         guard let result = try await viewModel.checkPassword(password: password) else {
             resultLabel.text = "Your password is safe"
             resultLabel.textColor = .black
             viewModel.saveCheck(check: .init(type: "Password Check",
                                              placement: "recentChecks",
                                              breaches: nil,
                                              stringResult: resultLabel.text ?? ""), recentCheck: true)
             checkSaved.send()
             return
         }
         resultLabel.text = "Your password has been compromised \(result) times"
         resultLabel.textColor = .black
         viewModel.saveCheck(check: .init(type: "Password Check",
                                          placement: "recentChecks",
                                          breaches: nil,
                                          stringResult: resultLabel.text ?? ""), recentCheck: true)
         checkSaved.send()
     }
     
     private func checkAccount(account: String) async throws {
         let result: [Breach] = try await viewModel.checkAccount(account: account)
         resultLabel.text = result.isEmpty ? "Your account is safe" : "Your account has been compromised \(result.count) times"
         resultLabel.textColor = .black
         viewModel.saveCheck(check: .init(type: "Account Check: \(inputTextField.text ?? "")",
                                          placement: "recentChecks",
                                          breaches: result,
                                          stringResult: resultLabel.text ?? ""), recentCheck: true)
         checkSaved.send()
     }
}
