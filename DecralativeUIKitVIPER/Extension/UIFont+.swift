//
//  UIFont+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/05.
//

import UIKit.UIFont

extension UIFont {
    static func defaultNormalFont(size: CGFloat) -> UIFont {
        UIFont(name: "HiraginoSans-W3", size: size)!
    }

    static func defaultBoldFont(size: CGFloat) -> UIFont {
        UIFont(name: "HiraginoSans-W6", size: size)!
    }
}
