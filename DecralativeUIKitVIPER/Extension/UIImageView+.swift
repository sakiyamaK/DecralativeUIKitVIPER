//
//  UIImageView+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/18.
//

import Kingfisher
import UIKit

extension UIImageView {
    @discardableResult
    func imageInformation(_ imageInformation: ImageInformation) -> Self {
        switch imageInformation.saveType {
        case .server:
            kf.setImage(with: imageInformation.filePath.url)
        case .asset:
            image(imageInformation.image)
        }
        return self
    }
}
