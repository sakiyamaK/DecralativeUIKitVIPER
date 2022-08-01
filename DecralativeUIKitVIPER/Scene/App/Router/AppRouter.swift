import UIKit

protocol AppWireframe: AnyObject {
    func runApp()
    func showRoot()
    func showStart()
    #if DEBUG
    func runTest()
    #endif
}

final class AppRouter {
    static var shared: AppRouter!
    private init(window: UIWindow & AppView) {
        self.window = window
    }

    private let window: (UIWindow & AppView)!
    private var presenter: AppPresenter!

    static func assembleModules() -> AppRouter {
        let router: AppRouter!
        let view: UIWindow!
        if let _shared = shared {
            router = _shared
            view = router.window
        } else {
            view = UIWindow(frame: UIScreen.main.bounds)
            router = AppRouter(window: view)
        }

        let interactor = AppInteractor(dependency: .init(defaultLaunchType: .root))
        router.presenter = AppPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        shared = router
        return router
    }
}

extension AppRouter: AppWireframe {
    func runApp() {
        presenter.runApp = ()
    }

    func showRoot() {
        let vc = GithubListRouter.assembleModules()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }

    func showStart() {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    #if DEBUG
    func runTest() {

    }
    #endif
}
