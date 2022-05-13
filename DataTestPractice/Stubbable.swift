//
//  Stubbable.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/13.
//

protocol Stubbable: Identifiable {
    static func stub(with id: Identifier<Self>) -> Self
}

extension Stubbable {
    func setting<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
