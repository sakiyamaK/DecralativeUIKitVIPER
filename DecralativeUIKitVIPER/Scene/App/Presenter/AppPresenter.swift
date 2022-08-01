// Copyright © The Chain Museum. All rights reserved.

import Foundation
import NSObject_Rx
import RxCocoa
import RxSwift

protocol AppPresentation: AnyObject {
    var runApp: Void? { get set }
}

final class AppPresenter: HasDisposeBag, AppPresentation {
    private weak var view: AppView?
    private let router: AppWireframe
    private var interactor: AppUsecase

    @RxPublished var runApp: Void?

    deinit { DLog() }

    init(
        view: AppView,
        interactor: AppUsecase,
        router: AppWireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router

        let viewDisposable: [Disposable] = [
            $runApp.bind(to: Binder(self) {_self, _ in
                _self.interactor.fetch = ()
            })
        ]
        let interactorDisposables: [Disposable] = [
            interactor.launchType.bind(to: Binder(self) { _, launchType in
                switch launchType {
                case .root:
                    router.showRoot()
                case .start:
                    router.showStart()
                }
            })
        ]

        disposeBag.insert(viewDisposable + interactorDisposables)
    }
}
