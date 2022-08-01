//
//  ObservableType+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/25.
//

import DeclarativeUIKit
import RxSwift
import UIKit

extension ObservableType where Element == Error {
    func handleError(for viewController: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) -> Disposable {
        observe(on: MainScheduler.instance).subscribe(onNext: { [weak viewController] error in
            guard let viewController = viewController else { return }
            guard let error = error as? AppError else {
                UIAlertController(title: "予期せぬエラーです", message: "", preferredStyle: .alert)
                    .addAction {
                        UIAlertAction(title: "閉じる", style: .cancel, handler: { action in
                            handler?(action)
                        })
                    }
                    .present(from: viewController, animated: true)
                return

            }
            UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
                .addAction {
                    UIAlertAction(title: "閉じる", style: .cancel, handler: { action in
                        handler?(action)
                    })
                }
                .present(from: viewController, animated: true)

        })
    }
}
