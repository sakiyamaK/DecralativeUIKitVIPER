import UIKit

protocol AppView: AnyObject {}

extension UIWindow: AppView {
    static var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.windows.first!.safeAreaInsets
    }
}
