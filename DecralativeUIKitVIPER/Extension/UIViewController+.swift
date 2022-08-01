//
//  UIViewController+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/05.
//

import UIKit.UIViewController

extension UIViewController {
    var withNavigationController: UINavigationController {
        UINavigationController(rootViewController: self)
    }
}

extension UIViewController {
    func show(next: UIViewController, animated: Bool, isPresent: Bool = false, completion: (() -> Void)? = nil) {
        if let nav = navigationController, !isPresent {
            nav.pushViewController(next, animated: animated)
            completion?()
        } else {
            present(next, animated: animated, completion: completion)
        }
    }

    func popOrDismiss(animated: Bool, completion: ((UINavigationController?) -> Void)? = nil) {
        guard let nav = navigationController else {
            dismiss(animated: animated, completion: { completion?(nil) })
            return
        }
        nav.popViewController(animated: animated)
        completion?(nav)
    }
}

// MARK: - containerview

extension UIViewController {
    func addContainer(viewController: UIViewController, containerView: UIView) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        viewController.didMove(toParent: self)
    }

    func removeContainer(viewController: UIViewController) {
        viewController.willMove(toParent: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    func removeAllContainer() {
        children.forEach {
            self.removeContainer(viewController: $0)
        }
    }
}
