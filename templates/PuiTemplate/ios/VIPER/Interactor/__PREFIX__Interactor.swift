
import Action
import Foundation
import NSObject_Rx
import RxCocoa
import RxOptional
import RxSwift

protocol __PREFIX__Usecase {
    var error: Observable<Error> { get }
}

struct __PREFIX__InteractorDependency {}

final class __PREFIX__Interactor: HasDisposeBag, __PREFIX__Usecase {
    deinit { DLog() }

    // inputs

    // outputs
    @RxPublished private var _error: Error?
    lazy var error = $_error.filterNil()

    init(dependency _: __PREFIX__InteractorDependency = .init()) {
        let disposables: [Disposable] = [
        ]

        disposeBag.insert(disposables)
    }
}
