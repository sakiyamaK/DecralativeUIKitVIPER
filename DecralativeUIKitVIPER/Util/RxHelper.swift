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
    private var value: Value
    private let _projectedValue = PublishRelay<Value>()
    private(set) lazy var projectedValue: Observable<Value> = _projectedValue.asObservable()

    var wrappedValue: Value {
        get { return value }
        set {
            value = newValue
            _projectedValue.accept(value)
        }
    }

    init(wrappedValue: Value) {
        value = wrappedValue
    }
}
