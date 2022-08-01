//
//  AppError.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/25.
//

import Foundation

enum AppError: Error {
    case api(title: String? = "通信エラーです", message: String? = nil)

    var title: String? {
        switch self {
        case let .api(title, _):
            return title
        }
    }

    var message: String? {
        switch self {
        case let .api(_, message):
            return message
        }
    }
}
