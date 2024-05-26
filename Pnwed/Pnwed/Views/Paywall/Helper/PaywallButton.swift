//
//  PaywallButton.swift
//  Pnwed
//
//  Created by Андрей Бобр on 26.05.24.
//

import Foundation
import UIKit
import Adapty

final class PaywallButton: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let selectImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Yearly"
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.7)
        return label
    }()
    
    init(product: AdaptyPaywallProduct?, type: SubscriptionType) {
        super.init(frame: .zero)
        
        setupLabels(product: product, type: type)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        addSubviews(containerView)
        containerView.addSubviews(priceLabel, selectImage, typeLabel, descriptionLabel)
        containerView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        priceLabel.snp.makeConstraints({
            $0.trailing.equalTo(-15)
            $0.centerY.equalTo(containerView)
            $0.width.equalTo(80)
        })
        
        selectImage.snp.makeConstraints({
            $0.leading.equalTo(15)
            $0.centerY.equalTo(containerView)
            $0.width.height.equalTo(20)
        })
        
        typeLabel.snp.makeConstraints({
            $0.bottom.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(selectImage.snp.trailing).offset(15)
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(selectImage.snp.trailing).offset(15)
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-5)
        })
    }
    
    func setupLabels(product: AdaptyPaywallProduct?, type: SubscriptionType) {
        typeLabel.text = type == .yearly ? "Yearly 19.99$" : "Weekly 1.99$"
        
        guard let product else { return }
        let currencySymbol = product.currencySymbol ?? "$"
        let price = "\(product.price)\(currencySymbol)"
        priceLabel.text = price
        
        let monthlyPayment = type == .yearly ? getYearlyPrice(price: product.price) : getWeeklyPrice(price: product.price)
        let billed = type == .yearly ? "Billed annualy" : "Billed Weekly"
        descriptionLabel.text = "\(currencySymbol)\(monthlyPayment)/\("month"). \(billed)"
    }
    
    func getYearlyPrice(price: Decimal) -> String {
        let yearlyPriceDouble = NSDecimalNumber(decimal: price).doubleValue
        let daily = yearlyPriceDouble / 365
        return "\((daily * 100).rounded(.down) / 100)"
    }
    
    func getWeeklyPrice(price: Decimal) -> String {
        let yearlyPriceDouble = NSDecimalNumber(decimal: price).doubleValue
        let daily = yearlyPriceDouble / 7
        return "\((daily * 100).rounded(.down) / 100)"
    }
    
    func animateTap() {
        UIView.animate(withDuration: 0.4) {
            self.transform = .init(scaleX: 1.03, y: 1.1)
            self.containerView.layer.borderColor = UIColor.systemBlue.cgColor
            self.containerView.layer.borderWidth = 2
        }
        
        UIView.transition(with: selectImage, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.selectImage.image = .init(systemName: "checkmark.circle.fill")
        })
    }
    
    func deselectTap() {
        UIView.animate(withDuration: 0.4) {
            self.transform = .init(scaleX: 1, y: 1)
            self.containerView.layer.borderColor = UIColor.systemBlue.cgColor
            self.containerView.layer.borderWidth = 0.5
        }
        
        UIView.transition(with: selectImage, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.selectImage.image = nil
        })
    }
}

public enum SubscriptionType {
    case yearly
    case weekly
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
