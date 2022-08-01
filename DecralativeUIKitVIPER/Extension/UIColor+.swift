//
//  UIColor+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/05.
//

import UIKit

extension UIColor {
    convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: red255 / 255, green: green255 / 255, blue: blue255 / 255, alpha: alpha)
    }

    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexCode = hex.replacingOccurrences(of: "#", with: "")

        if hexCode.count == 3 {
            let v: [String] = hexCode.map { String($0) }
            let r = CGFloat(Int(v[0], radix: 16) ?? 0) / 15.0
            let g = CGFloat(Int(v[1], radix: 16) ?? 0) / 15.0
            let b = CGFloat(Int(v[2], radix: 16) ?? 0) / 15.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        } else if hexCode.count == 6 {
            let v: [String] = hexCode.map { String($0) }
            let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
            let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
            let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        } else {
            // 失敗
            self.init(white: 1, alpha: 1)
        }
    }

    private func colorValue(index: Int) -> CGFloat {
        guard let components = cgColor.components else { return 0 }
        return components[safe: index] ?? 0
    }

    var redValue: CGFloat { colorValue(index: 0) }
    var greenValue: CGFloat { colorValue(index: 1) }
    var blueValue: CGFloat { colorValue(index: 2) }
    var alphaValue: CGFloat { colorValue(index: 3) }

    var inverse: UIColor {
        UIColor(red: 1.0 - redValue, green: 1.0 - greenValue, blue: 1.0 - blueValue, alpha: alphaValue)
    }
}

extension UIColor {
    private static var appWhite: UIColor { .init(hex: "#FFFFFF") }
    private static var appBlack: UIColor { .init(red255: 0, green255: 0, blue255: 0) }
    private static var appRed: UIColor { .init(hex: "#FF4B6C") }
    private static var appGray: UIColor { .init(hex: "#9CA0AD") }
    private static var appBlue: UIColor { .init(hex: "#2B65F6") }
    private static var appGreen: UIColor { .init(hex: "#4ACE97") }

    static var viewBackgroundColor: UIColor { appWhite }
    static var emptyBackgroundColor: UIColor { appGray }
    static var firstTextColor: UIColor { appBlack }
    static var secondTextColor: UIColor { appGray }
    static var firstTextInverseColor: UIColor { firstTextColor.inverse }
    static var secondTextInverseColor: UIColor { secondTextColor.inverse }
    static var firstBorderColor: UIColor { appBlack }
    static var secondBorderColor: UIColor { appGray }
    static var alertTextColor: UIColor { appRed }
    static func opacityBackgroundColor(alpha: CGFloat = 0.6) -> UIColor { appBlack.withAlphaComponent(alpha) }
    static var defaultIndicatorColor: UIColor { appWhite }
    static var shadowColor: UIColor { appBlack.withAlphaComponent(0.08) }
}
