//
//  PersonDataTest.swift
//  DataTestPracticeTests
//
//  Created by 박진섭 on 2022/05/13.
//

import XCTest

class PersonDataTest: XCTestCase {
    
    var sut: People!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = People()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAddPerson() throws {
        sut = People()
        
        let person0 = Person(
            id: "Park",
            name: "kim",
            address: Address(nation: "korea"),
            family: []
        )
        
        XCTAssertFalse(sut.people.contains(person0))
        
        sut.addPerson(person: person0)
        
        XCTAssertTrue(sut.people.contains(person0))
    }
}
