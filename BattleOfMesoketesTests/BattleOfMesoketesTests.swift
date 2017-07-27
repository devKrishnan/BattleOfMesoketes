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
    func testAttack(){
        
    }
    func testDirection(){
        let direction = Direction(rawValue: "Test")
        XCTAssertNil(direction, "Invalid direction")
        let wDirection = Direction(rawValue: "W")
        XCTAssertNotNil(wDirection, "Valid direction")
        let eDirection = Direction(rawValue: "E")
        XCTAssertNotNil(eDirection, "Valid direction ")
        let nDirection = Direction(rawValue: "N")
        XCTAssertNotNil(nDirection, "Valid direction ")
        let sDirection = Direction(rawValue: "S")
        XCTAssertNotNil(sDirection, "Valid direction direction")
        XCTAssertEqual(sDirection?.rawValue, "S", "Both are south direction")
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
