//
//  APITargetType.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import Moya
import RxSwift

extension BaseTargetType {
    var sampleData: Data {
        return "{}".data(using: .utf8)! // use empty JSON by default
    }

    var headers: [String: String]? {
        return nil
        //        return ["User-Agent": AppInfo.userAgent]
    }
}

protocol APITargetType: BaseTargetType {
}

/// For API
extension APITargetType {
    static var listParameterSeparator: String { "," }

    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
}
