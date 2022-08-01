//
//  NSObject+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/02/19.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }

    var className: String {
        String(describing: self)
    }
}
