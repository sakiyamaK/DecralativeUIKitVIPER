//
//  UIStackView+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/18.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubViews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
