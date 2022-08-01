//
//  OwnerModel.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/08/01.
//

import Foundation

struct OwnerModel: Codable {
    var id: Int
    var name: String
    var iconURLStr: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "login", iconURLStr = "avatarUrl"
    }
}
