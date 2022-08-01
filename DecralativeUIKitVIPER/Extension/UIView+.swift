//
//  UIView+.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/23.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIView {
    var tapGesture: Observable<Void> {
        let tapGesture = base.tapGestureForNumber(of: 1)
        return tapGesture.rx.event.map(void)
    }

    // TODO
    var tapGestureThrottle: Observable<Void> {
        self.tapGesture
    }
}

extension UIView {
    var isShow: Bool {
        get {
            !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
}

extension UIView {
    func tapGesturesForNumber(of taps: Int) -> [UITapGestureRecognizer] {
        guard let gestures = gestureRecognizers else {
            return []
        }

        return gestures.compactMap { $0 as? UITapGestureRecognizer }.filter { $0.numberOfTapsRequired == taps }
    }

    func tapGestureForNumber(of taps: Int) -> UITapGestureRecognizer {
        objc_sync_enter(self)
        let tapGesture: UITapGestureRecognizer
        if let gesture = tapGesturesForNumber(of: taps).first {
            tapGesture = gesture
        } else {
            tapGesture = UITapGestureRecognizer()
            tapGesture.numberOfTapsRequired = taps
            addGestureRecognizer(tapGesture)
        }
        objc_sync_exit(self)
        return tapGesture
    }
}
