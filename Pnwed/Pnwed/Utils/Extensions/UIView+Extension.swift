//
//  UIView+Extension.swift
//  Pnwed
//
//  Created by Андрей Бобр on 27.05.24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
