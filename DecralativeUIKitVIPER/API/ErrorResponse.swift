//
//  ErrorResponse.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Foundation

struct ErrorResponse: Error, Decodable {
    let statusCode: Int

    var title: String {
        ""
    }

    var message: String {
        ""
    }
}
