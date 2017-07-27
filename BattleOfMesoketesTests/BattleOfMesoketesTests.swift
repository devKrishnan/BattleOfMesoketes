//
//  BattleOfMesoketesTests.swift
//  BattleOfMesoketesTests
//
//  Created by radhakrishnan S on 27/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import BattleOfMesoketes

class BattleOfMesoketesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testDirection(){
        let direction = Direction(rawValue: "Test")
        XCTAssertNil(direction, "Valid direction")
        let wDirection = Direction(rawValue: "W")
        XCTAssertNotNil(wDirection, "Invalid direction")
        let eDirection = Direction(rawValue: "E")
        XCTAssertNotNil(eDirection, "Invalid direction ")
        let nDirection = Direction(rawValue: "N")
        XCTAssertNotNil(nDirection, "Invalid direction ")
        let sDirection = Direction(rawValue: "S")
        XCTAssertNotNil(sDirection, "Invalid direction direction")
        XCTAssertEqual(sDirection?.rawValue, "S", "Both are not South direction")
        
    }
    func testWall(){
        
    }
    func testTribe(){
        let json = [ "name": "1" ]
        let tribe =  Tribe(tribeJSON: json)
        XCTAssertNotNil(tribe, "Invalid tribe")
        XCTAssertEqual(tribe?.tribeName, "1", "Names are different")
        XCTAssertNotEqual(tribe?.tribeName, "2", "Names are Same")

    }
    func testAttack(){
        let json = [
            "tribe": [ "name": "1" ],
            "direction": "N",
            "strength": 3
        ] as [String : Any]
        let attack = Attack(attackJSON: json)
        XCTAssertNotNil(attack, "Invalid attack data")
        XCTAssertEqual(attack?.direction.rawValue, "N", "Directions are different")
        XCTAssertNotEqual(attack?.direction.rawValue, "W", "Directions are same")
        XCTAssertEqual(attack?.strength, 3, "Strengths are different")
        XCTAssertNotEqual(attack?.strength, 2, "Strengths are same")
        let invalidJson = [
            "tribe": [ "name": "1" ],
            "direction": "N",
            "strength": 3
            ] as [String : Any]
        let invalidAttack = Attack(attackJSON: invalidJson)
        XCTAssertNotNil(invalidAttack, "Valid attack data")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
