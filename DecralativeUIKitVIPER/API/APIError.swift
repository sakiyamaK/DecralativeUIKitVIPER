//
//  APIError.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Foundation

enum ApiError: Error {
    case requestFailed(Int)
    case decodeFailed(Error)
    case unknown

    var description: String { failureReason }

    // デバッグ用
    var failureReason: String {
        switch self {
        case let .requestFailed(statusCode):
            return "ApiError : Unavailable status code: \(statusCode)"
        case let .decodeFailed(raw):
            return "ApiError : Failed to decode \(raw)"
        case .unknown:
            return "ApiError : Unknown error"
        }
    }

    var title: String { "エラーです" }

    var message: String { "詳細なエラー情報です" }
}
