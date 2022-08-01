//
//  Todo.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import Foundation

struct GithubModel: Codable {
    let id: Int
    let name: String
    let owner: OwnerModel

    enum CodingKeys: String, CodingKey {
        case id, name, owner
    }
}

extension GithubModel {
    private static var jsonStr: String {
        """
    {
    "id": 999,
    "name": "test",
    "owner": {
        "id": 1,
        "name": "ほげやま",
        "avatar_url": "https://avatars.githubusercontent.com/u/1858528?v=4"
    }
    }
    """
    }

    static var sample: GithubModel {
        try! JSONDecoder().decode(
            GithubModel.self,
            from:
                GithubModel.jsonStr.data(using: .utf8)!
        )
    }
}
