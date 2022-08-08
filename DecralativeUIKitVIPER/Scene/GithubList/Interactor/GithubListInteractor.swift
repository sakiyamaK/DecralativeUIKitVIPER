import Action
import Foundation
import NSObject_Rx
import RxCocoa
import RxOptional
import RxSwift

protocol GithubListUsecase {
    var fetch: String? { get set }

    var githubListEntities: [GithubListEntity]? { get }
    var githubListEntitiesObservable: Observable<[GithubListEntity]> { get }
    var error: Observable<Error> { get }
}

struct GithubListInteractorDependency {
    var api: APIProtocol
}

final class GithubListInteractor: HasDisposeBag, GithubListUsecase {

    deinit { DLog() }

    // inputs
    @RxPublished var fetch: String?

    // outputs
    @RxPublished var githubListEntities: [GithubListEntity]?
    lazy var githubListEntitiesObservable = $githubListEntities.filterNil()

    @RxPublished private var _error: Error?
    lazy var error = $_error.filterNil()

    init(dependency: GithubListInteractorDependency) {

        let apiAction = Action<String, GithubListResponse> { searchWord in
            dependency.api.request(
                GithubSearchRepositoriesRequest(parameter: .init(searchWork: searchWord))
            ).share(replay: 1, scope: .whileConnected)
        }

        let disposables: [Disposable] = [
            $fetch.filterNil().filterEmpty().debug().bind(to: apiAction.inputs),
            apiAction.errors.convertApiError().debug().bind(to: Binder(self) {_self, error in
                _self._error = error
            }),
            apiAction.elements.debug().bind(to: Binder(self) {_self, response in
                _self.githubListEntities = response.items
            })
        ]

        disposeBag.insert(disposables)
    }
}
