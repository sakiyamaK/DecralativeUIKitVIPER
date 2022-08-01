import DeclarativeUIKit
import RxCocoa
import RxSwift
import UIKit

protocol GithubListView: AnyObject {
    var reloadData: Void? { get set }
    var showError: Error? { get set }
}

final class GithubListViewController: UIViewController, GithubListView {
    deinit { DLog() }

    @RxPublished var reloadData: Void?
    @RxPublished var showError: Error?

    private weak var searchTextField: UITextField!
    private weak var searchButton: UIButton!
    private weak var collectionView: UICollectionView!

    private var presenter: GithubListPresentation!
    func inject(presenter: GithubListPresentation) {
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

private extension GithubListViewController {
    func bind() {
        let disposables: [Disposable] = [
            rx.viewWillAppear.bind(to: Binder(self) { _, _ in
                // vc.presenter.initView = ()
            }),
            $reloadData.filterNil().debug().bind(to: Binder(self) {_self, _ in
                _self.collectionView.reloadData()
            }),

            $showError.filterNil().handleError(for: self, handler: nil),

            searchButton.rx.tap.bind(to: Binder(self) {_self, _ in
                _self.presenter.searchWord = _self.searchTextField.text
            })
        ]

        let otherDispobales: [Disposable] = [
            rx.viewWillAppear.bind(to: Binder(self) { _, _ in
            })
        ]

        rx.disposeBag.insert(disposables + otherDispobales)
    }
}

// MARK: - hotreload method

@objc private extension GithubListViewController {
    func updateLayout() {
        view.backgroundColor = .viewBackgroundColor

        declarative {
            UIStackView.vertical {

                UIStackView.horizontal({
                    UITextField(assign: &searchTextField)
                        .text("DeclarativeUIKit")
                        .padding()
                        .border(color: .firstBorderColor, width: 1)
                        .cornerRadius(8)
                        .customSpacing(10)
                    UIButton(assign: &searchButton)
                        .image(UIImage(systemName: "magnifyingglass"))
                }).padding()

                UICollectionView(UICollectionViewCompositionalLayout.verticalList(height: 80))
                    .assign(to: &collectionView)
                    .registerCellClass(GithubListCollectionViewCell.self, forCellWithReuseIdentifier: GithubListCollectionViewCell.className)
                    .dataSource(self)
                    .delegate(self)
            }
        }
    }
}

// MARK: -

extension GithubListViewController: UICollectionViewDelegate {

}

extension GithubListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DLog()
        return presenter.githubListEntities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        DLog()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GithubListCollectionViewCell.className, for: indexPath) as! GithubListCollectionViewCell
        let githubListEntity = presenter.githubListEntities[indexPath.row]
        return cell.configure(githubListEntity: githubListEntity)
    }
}
