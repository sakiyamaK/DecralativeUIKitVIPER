//
//  ImageType.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/16.
//

import Foundation
import Kingfisher
import KingfisherWebP

struct ImageInformation: Decodable {
    enum SaveType: String {
        case asset, server
    }

    var saveType: SaveType
    var filePath: String

    private enum CodingKeys: String, CodingKey {
        case saveType, filePath
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let saveTypeStr = (try? c.decode(String.self, forKey: .saveType)) ?? ImageInformation.SaveType.server.rawValue
        saveType = SaveType(rawValue: saveTypeStr) ?? ImageInformation.SaveType.server
        filePath = try c.decode(String.self, forKey: .filePath)
    }

    init(saveType: SaveType, filePath: String) {
        self.saveType = saveType
        self.filePath = filePath
    }
}

import UIKit
extension ImageInformation {
    var image: UIImage? {
        switch saveType {
        case .server:
            return nil
        case .asset:
            return nil
        }
    }

    var url: URL? {
        switch saveType {
        case .server:
            return filePath.url
        case .asset:
            return filePath.url
        }
    }
}

extension String {
    var imageServerInformation: ImageInformation? {
        guard url != nil else { return nil }
        return .init(saveType: ImageInformation.SaveType.server, filePath: self)
    }
}

extension Optional where Wrapped == String {
    var imageServerInformation: ImageInformation? {
        guard let self = self else { return nil }
        return self.imageServerInformation
    }
}
