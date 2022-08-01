//
//  GithubListRequest.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import Foundation
import Moya

struct GithubSearchRepositoriesRequest: APITargetType {

    typealias Response = GithubListResponse

    let method: Moya.Method = .get
    let path = "/search/repositories"
    var task: Task {
        return .requestParameters(parameters: parameter.requestParameters, encoding: URLEncoding.queryString)
    }

    struct Parameter {
        let searchWork: String
        var requestParameters: [String: Any] {
            [
                "q": searchWork
            ]
        }
    }

    let parameter: Parameter
    init(parameter: Parameter) {
        self.parameter = parameter
    }
}
