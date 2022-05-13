//
//  Extension.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/13.
//

extension Array where Element: Stubbable, Element.RawIdentifier == String {
    static func stub(withCount count: Int) -> Array {
        return (0..<count).map {
            .stub(with: Identifier(rawValue: "\($0)"))
        }
    }
}

extension MutableCollection where Element: Stubbable {
    func setting<T>(_ keyPath: WritableKeyPath<Element, T>,
                    to value: T) -> Self {
        var collection = self

        for index in collection.indices {
            let element = collection[index]
            collection[index] = element.setting(keyPath, to: value)
        }

        return collection
    }
}
