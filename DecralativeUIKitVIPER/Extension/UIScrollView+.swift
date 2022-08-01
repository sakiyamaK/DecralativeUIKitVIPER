//
//  UIScrollView+Rx.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/06/18.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIScrollView {
    var currentPage: Observable<Int> {
        Observable.merge(
            didEndScrollingAnimation.map(void),
            didEndDecelerating.map(void)
        ).map {
            self.base.currentPage
        }
    }
}

extension UIScrollView {
    var isLastPage: Bool {
        lastPage == currentPage
    }

    var isFirstPage: Bool {
        currentPage == 0
    }

    var lastPage: Int {
        let pageWidth = frame.width
        if pageWidth == 0 { return 0 }
        let page = floor(contentSize.width / pageWidth) - 1
        return Int(page)
    }

    var currentPage: Int {
        let pageWidth = frame.width
        if pageWidth == 0 { return 0 }
        let page = floor((contentOffset.x - pageWidth / 2) / pageWidth) + 1
        return Int(page)
    }

    func setCurrentPage(_ page: Int, animated: Bool) {
        var rect = bounds
        rect.origin.x = rect.width * CGFloat(page)
        rect.origin.y = 0
        scrollRectToVisible(rect, animated: animated)
    }

    func goNextPage(animated: Bool) {
        setCurrentPage(min(currentPage + 1, lastPage), animated: animated)
    }

    func goPrevPage(animated: Bool) {
        setCurrentPage(max(currentPage - 1, 0), animated: animated)
    }
}
