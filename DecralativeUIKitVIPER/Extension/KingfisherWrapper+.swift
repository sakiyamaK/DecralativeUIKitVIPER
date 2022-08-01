//
//  KingfisherWrapper+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Kingfisher
import KingfisherWebP

extension KingfisherWrapper where Base == UIImageView {
    @discardableResult
    func setImageWithBasicAuth(with url: URL?, options: KingfisherOptionsInfo? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> Base {
        let opt: KingfisherOptionsInfo = (options ?? []) + (.authorizedItems ?? []) + [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)]
        setImage(with: url, options: opt, completionHandler: completionHandler)
        return base
    }
}

extension KingfisherWrapper where Base == UIButton {
    func setImageWithBasicAuth(with url: URL?, for state: UIControl.State, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let opt: KingfisherOptionsInfo = (options ?? []) + (.authorizedItems ?? []) + [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)]
        setImage(with: url, for: state, placeholder: placeholder, options: opt, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}

private extension Array where Element == Kingfisher.KingfisherOptionsInfoItem {
    static let authorizedItems: KingfisherOptionsInfo? = {
        if API.shared.hostType.shouldNeedBasicAuth, let password = API.shared.hostType.basicAuthPassword {
            let modifier = AnyModifier { req in
                var req = req
                // TODO: basic認証のtokenを用意 現在は仮の文字列を入れてる
                let token = "ServiceName:\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
                req.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
                return req
            }
            return [.requestModifier(modifier)]
        } else {
            return nil
        }
    }()
}
