//
//  API.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Alamofire
import Moya
import RxSwift

protocol BaseTargetType: TargetType {
    associatedtype Response: Decodable
}

protocol APIProtocol {
    func request<Request>(_ request: Request) -> Observable<Request.Response> where Request: BaseTargetType
}

extension APIProtocol {
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    fileprivate static func makeErrorResponseData(from response: Response) -> Data {
        guard var obj = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions()) as? [String: Any] ?? [String: Any]() else {
            return response.data
        }

        obj["status_code"] = response.statusCode
        if let data = try? JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions()) {
            return data
        }
        return response.data
    }
}

final class API: APIProtocol {
    enum ServiceHostType: CaseIterable {
        case debug, staging, release
        var serviceHost: String {
            switch self {
            case .debug:
                return ""
            case .staging:
                return ""
            case .release:
                return ""
            }
        }

        var basicAuthUsername: String {
            switch self {
            case .debug:
                return ""
            case .staging:
                return ""
            case .release:
                return ""
            }
        }

        var basicAuthPassword: String? {
            switch self {
            case .debug:
                return nil
            case .staging:
                return nil
            case .release:
                return nil
            }
        }

        var shouldNeedBasicAuth: Bool { basicAuthPassword != nil }

        var timeoutIntervalForRequest: Double {
            switch self {
            case .debug:
                return 10.0
            case .staging:
                return 30.0
            case .release:
                return 30.0
            }
        }
    }

    static let shared = API()
    private(set) var hostType: ServiceHostType
    private init() {
        #if DEBUG
        hostType = ServiceHostType.debug
        #elseif STAGING
        hostType = ServiceHostType.staging
        #else
        hostType = ServiceHostType.release
        #endif
    }

    private lazy var configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = hostType.timeoutIntervalForRequest
        return configuration
    }()

    private lazy var provider: MoyaProvider<MultiTarget> = {
        var plagins: [PluginType] = [CachePolicyPlugin()]
        if hostType.shouldNeedBasicAuth, let password = hostType.basicAuthPassword {
            plagins.append(CredentialsPlugin { _ -> URLCredential? in
                URLCredential(user: self.hostType.basicAuthUsername,
                              password: password,
                              persistence: .none)
            })
        }
        return MoyaProvider<MultiTarget>(
            session: Alamofire.Session(configuration: configuration),
            plugins: plagins
        )
    }()

    func request<Request>(_ request: Request) -> Observable<Request.Response> where Request: BaseTargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .flatMap { response in
                guard (200 ..< 300).contains(response.statusCode) else {
                    if (400 ..< 500).contains(response.statusCode) {
                        do {
                            let errorResponse = try Self.jsonDecoder.decode(ErrorResponse.self, from: Self.makeErrorResponseData(from: response))
                            return .error(errorResponse)
                        } catch {
                            DLog("Failed to decode ErrorResponse: \(error), original: \(String(data: response.data, encoding: .utf8) ?? "")")
                            return .error(ApiError.decodeFailed(error))
                        }
                    } else {
                        DLog("Unavailable status code: \(response.statusCode)")
                        return .error(ApiError.requestFailed(response.statusCode))
                    }
                }

                do {
                    #if DEBUG
                    if ProcessInfo.processInfo.environment["API_LOG"] != nil {
                        DLog("request: \(request)")
                        DLog("response: \(String(data: response.data, encoding: .utf8) ?? "")")
                    }
                    #endif
                    let response = try Self.jsonDecoder.decode(Request.Response.self, from: response.data)
                    return .just(response)
                } catch {
                    DLog("Failed to decode \(Request.Response.self): \(error), original: \(String(data: response.data, encoding: .utf8) ?? "")")
                    return .error(ApiError.requestFailed(response.statusCode))
                }
            }
            .asObservable()
            .catch { e in
                if let _e = e as? ApiError { return .error(_e) }
                return .error(ApiError.unknown)
            }
    }

    func request<Request>(_ request: Request) -> Observable<Void> where Request: BaseTargetType, Request.Response == EmptyResponse {
        let response: Observable<Request.Response> = self.request(request)
        return response.map(void)
    }
}

final class APIStub: APIProtocol {
    static let shared = APIStub()
    private init() {}

    private var provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider<MultiTarget>.delayedStub(1))

    func request<Request>(_ request: Request) -> Observable<Request.Response> where Request: BaseTargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .flatMap { response in
                guard (200 ..< 300).contains(response.statusCode) else {
                    if (400 ..< 500).contains(response.statusCode) {
                        do {
                            let errorResponse = try Self.jsonDecoder.decode(ErrorResponse.self, from: Self.makeErrorResponseData(from: response))
                            return .error(errorResponse)
                        } catch {
                            DLog("[Stub] Failed to decode ErrorResponse: \(error)")
                            return .error(ApiError.decodeFailed(error))
                        }
                    } else {
                        DLog("[Stub] Unavailable status code: \(response.statusCode)")
                        return .error(ApiError.requestFailed(response.statusCode))
                    }
                }

                do {
                    let response = try Self.jsonDecoder.decode(Request.Response.self, from: response.data)
                    return .just(response)
                } catch {
                    DLog("[Stub] Failed to decode \(Request.Response.self): \(error)")
                    return .error(ApiError.decodeFailed(error))
                }
            }
            .asObservable()
    }

    func request<Request>(_ request: Request) -> Observable<Void> where Request: BaseTargetType, Request.Response == EmptyResponse {
        let response: Observable<Request.Response> = self.request(request)
        return response.map(void)
    }
}
