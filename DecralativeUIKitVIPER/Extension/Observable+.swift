//
//  Observable+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/18.
//

import Action
import Foundation
import RxSwift

extension Observable where Element == ActionError {
    func convertApiError(_ notEnabledObservable: Observable<Error> = .empty()) -> Observable<Error> {
        return flatMap { _ -> Observable<Error> in
            .just(AppError.api())
        }
    }
    func convertError(_ notEnabledObservable: Observable<Error> = .empty()) -> Observable<Error> {
        return flatMap { error -> Observable<Error> in
            switch error {
            case let .underlyingError(error): return .just(error)
            case .notEnabled: return notEnabledObservable
            }
        }
    }
}
