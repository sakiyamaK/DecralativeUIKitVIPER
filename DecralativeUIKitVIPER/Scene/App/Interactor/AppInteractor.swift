import Action
import Foundation
import NSObject_Rx
import RxCocoa
import RxSwift
import RxOptional

protocol AppUsecase {
    var fetch: Void? { get set }

    var error: Observable<Error> { get }
    var launchType: Observable<LaunchType> { get }
}

struct AppInteractorDependency {
    var defaultLaunchType: LaunchType
}

final class AppInteractor: HasDisposeBag, AppUsecase {
    // inputs
    @RxPublished var fetch: Void?

    // outputs
    @RxPublished private var _error: Error?
    lazy var error: Observable<Error> = $_error.filterNil().asObservable()

    @RxPublished private var _launchType: LaunchType?
    lazy var launchType: Observable<LaunchType> = $_launchType.filterNil().asObservable()

    deinit { DLog() }

    init(dependency: AppInteractorDependency) {

        let disposables: [Disposable] = [
            $fetch.filterNil().compactMap { _ in
                dependency.defaultLaunchType
            }.bind(to: Binder(self) {_self, launchType in
                _self._launchType = launchType
            })
        ]

        disposeBag.insert(disposables)
    }
}
