// Copyright © The Chain Museum. All rights reserved.

import Foundation
import NSObject_Rx
import RxCocoa
import RxSwift

protocol __PREFIX__Presentation: AnyObject {}

final class __PREFIX__Presenter: HasDisposeBag, __PREFIX__Presentation {
    deinit { DLog() }

    private weak var view: __PREFIX__View?
    private let router: __PREFIX__Wireframe
    private var interactor: __PREFIX__Usecase

    // input

    // output

    init(
        view: __PREFIX__View,
        interactor: __PREFIX__Usecase,
        router: __PREFIX__Wireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router

        let viewDisposables: [Disposable] = [
        ]
        let interactorDisposables: [Disposable] = [
        ]

        disposeBag.insert(viewDisposables + interactorDisposables)
    }
}
