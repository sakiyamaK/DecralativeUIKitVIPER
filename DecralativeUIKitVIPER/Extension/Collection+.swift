//
//  Array+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/25.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
