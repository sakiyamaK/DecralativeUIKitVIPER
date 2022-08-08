//
//  RxHelper.swift
//  DecralativeUIKitVIPER
//
//  Created by sakiyamaK on 2022/03/17.
//

import Foundation
import RxCocoa
import RxSwift

func void<Element>(_: Element) {
    return ()
}

@propertyWrapper
struct RxPublished<Value> {
    private let _projectedValue: BehaviorRelay<Value>
    private(set) lazy var projectedValue: Observable<Value> = _projectedValue.asObservable().observe(on: MainScheduler.instance)
    var wrappedValue: Value {
        get { return _projectedValue.value }
        set { _projectedValue.accept(newValue) }
    }

    init(wrappedValue: Value) {
        _projectedValue = .init(value: wrappedValue)
    }
}
