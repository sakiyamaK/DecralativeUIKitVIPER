// Copyright © The Chain Museum. All rights reserved.

import Foundation
import NSObject_Rx
import RxCocoa
import RxSwift

protocol GithubListPresentation: AnyObject {
    var searchWord: String? { get set }

    var githubListEntities: [GithubListEntity] { get }
}

final class GithubListPresenter: HasDisposeBag, GithubListPresentation {
    deinit { DLog() }

    private weak var view: GithubListView?
    private let router: GithubListWireframe
    private var interactor: GithubListUsecase

    // input
    @RxPublished var searchWord: String?

    // output
    var githubListEntities: [GithubListEntity] { interactor.githubListEntities ?? [] }

    init(
        view: GithubListView,
        interactor: GithubListUsecase,
        router: GithubListWireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router

        let viewDisposables: [Disposable] = [
            $searchWord.debug().bind(to: Binder(self) {_self, searchWord in
                _self.interactor.fetch = searchWord
            })

        ]
        let interactorDisposables: [Disposable] = [
            interactor.githubListEntitiesObservable.bind(to: Binder(self) {_self, _ in
                _self.view?.reloadData = ()
            }),
            interactor.error.bind(to: Binder(self) {_self, error in
                _self.view?.showError = error
            })
        ]

        disposeBag.insert(viewDisposables + interactorDisposables)
    }
}
