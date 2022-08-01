//
//  UserDefault+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/05.
//

import Foundation

private let authKey = "authKey"

extension UserDefaults {
    var auth: String {
        get {
            string(forKey: authKey) ?? ""
        }
        set {
            set(newValue, forKey: authKey)
        }
    }

    var isLogined: Bool {
        !auth.isEmpty
    }
}
