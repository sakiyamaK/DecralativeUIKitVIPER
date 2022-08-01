//
//  String+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/05.
//

import UIKit

extension String {
    static func localize(_ key: Localize.Key) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }

    init(localize key: Localize.Key) {
        self = NSLocalizedString(key.rawValue, comment: "")
    }
}

extension String {
    var url: URL? { URL(string: self) }
}

extension Optional where Wrapped == String {
    var isEmpty: Bool {
        self?.isEmpty ?? true
    }

    var isNotEmpty: Bool {
        !isEmpty
    }

    var url: URL? {
        guard let self = self else {
            return nil
        }
        return self.url
    }
}
