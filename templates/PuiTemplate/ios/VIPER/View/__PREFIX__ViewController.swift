
import DeclarativeUIKit
import RxCocoa
import RxSwift
import UIKit

protocol __PREFIX__View: AnyObject {}

final class __PREFIX__ViewController: UIViewController, __PREFIX__View {
    deinit { DLog() }

    private var presenter: __PREFIX__Presentation!
    func inject(presenter: __PREFIX__Presentation) {
        self.presenter = presenter
    }

    override func loadView() {
        super.loadView()
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(updateLayout), object: nil)
        updateLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

// MARK: - private method

private extension __PREFIX__ViewController {
    func bind() {
        let disposables: [Disposable] = [
            rx.viewWillAppear.bind(to: Binder(self) { _, _ in
                // vc.presenter.initView = ()
            }),
        ]

        let otherDispobales: [Disposable] = [
            rx.viewWillAppear.bind(to: Binder(self) { vc, _ in
            }),
        ]

        rx.disposeBag.insert(disposables + otherDispobales)
    }
}

// MARK: - hotreload method

@objc private extension __PREFIX__ViewController {
    func updateLayout() {
        view.backgroundColor = .viewBackgroundColor

        declarative {
            UIScrollView.vertical {
                UIStackView.vertical {
                    UILabel(__PREFIX__ViewController.className)
                        .textAlignment(.center)
                        .backgroundColor(.red)
                }
            }
        }
    }
}
