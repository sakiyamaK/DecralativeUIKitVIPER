//
//  CachePolicy.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Foundation
import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let multiTarget = target as? MultiTarget,
           case let .target(targetType) = multiTarget,
           let cachePolicyGettable = targetType as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        } else if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        return request
    }

    #if DEBUG
    func willSend(_ request: RequestType, target _: TargetType) {
        if ProcessInfo.processInfo.environment["API_LOG"] != nil {
            DLog(request.request?.url?.absoluteString ?? "Something is wrong")
        }
    }
    #endif
}
