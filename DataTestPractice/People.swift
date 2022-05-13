//
//  People.swift
//  DataTestPractice
//
//  Created by 박진섭 on 2022/05/13.
//

struct People {
    var people: [Person] = []
    
    mutating func addPerson(person: Person) {
        self.people.append(person)
    }
    
}
