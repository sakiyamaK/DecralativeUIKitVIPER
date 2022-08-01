import UIKit

protocol GithubListWireframe: AnyObject {}

final class GithubListRouter {
    deinit { DLog() }

    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = GithubListViewController()
        let interactor = GithubListInteractor(dependency: .init(api: API.shared))
        let router = GithubListRouter(viewController: view)
        let presenter = GithubListPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.inject(presenter: presenter)
        return view
    }
}

extension GithubListRouter: GithubListWireframe {}
