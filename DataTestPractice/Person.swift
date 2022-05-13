//
//  Person.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/12.
//

import Foundation

struct Person:Identifiable  {
    let id:Identifier<Person>
    var name: String
    var address: Address
    var family: [Person]
}

extension Person: Stubbable {
    static func stub(with id: Identifier<Person>) -> Person {
        return Person(
            id: id,
            name: "Park",
            address: Address(nation: "Korea"),
            family: []
        )
    }
}

extension Person:Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}

struct Address {
    let nation: String
}









