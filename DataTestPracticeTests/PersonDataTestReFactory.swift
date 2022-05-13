//
//  DataTestPracticeTests.swift
//  DataTestPracticeTests
//
//  Created by 박진섭 on 2022/05/12.
//

import XCTest

class PersonDataTestReFactory: XCTestCase {
    
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
        let person0 = Person.stub(with: "Park").setting(\.address, to: Address(nation: "U.S.A"))
        XCTAssertFalse(sut.people.contains(person0))
        
        sut.addPerson(person: person0)
        XCTAssertTrue(sut.people.contains(person0))
    }
}
