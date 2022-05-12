//
//  Person.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/12.
//

import Foundation

struct Person:Identifiable  {
    let id:Identifier<Person>
    let name: String
    let address: Address
    var family: [Person]
}

extension Person: Stubbable {
    static func stub(with id: Identifier<Person>) -> Person {
        return Person(
            id: id,
            name: "",
            address: Address(nataion: "Korea"),
            family: []
        )
    }
}


struct Address {
    let nataion: String
}


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

//let person = Person.stub(with: "ID").setting(\.name, to: "Park")

let person = Person.stub(with: "ID")
let person0 = person.setting(\.name, to: "Kim")
