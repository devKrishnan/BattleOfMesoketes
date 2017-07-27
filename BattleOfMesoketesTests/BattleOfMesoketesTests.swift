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
    func testFortFactoryImplementation(){
        var fort = Fort()
        let north = "N"
        XCTAssertNotNil(fort, "Invalid fort")
        if let direction = Direction(rawValue: north){
            let wall = fort.wall(inDirection: direction, defaultHeight: 0)
            XCTAssertEqual(wall.height, 0, "THe height of wall should be 0")
            XCTAssertEqual(wall.direction.rawValue, north, "THe direction of wall should be \(north)")
            let newHeight : UInt = 1
            fort.updateWallHeight(inDirection: direction, height: newHeight)
            let wallUpdatedHeight = fort.wall(inDirection: direction, defaultHeight: 0)
            XCTAssertEqual(wallUpdatedHeight.height, newHeight, "The heights are not equal. THe updated height of wall should be \(newHeight)")
            XCTAssertNotEqual(wallUpdatedHeight.height, newHeight + UInt(1), "The height of the walls are equal")
        }
        
    }
    func testWallAttack(){
        if let direction = Direction(rawValue: "N"){
            var wall = Wall(direction: direction, height: 1)
            let json = [
                "tribe": [ "name": "1" ],
                "direction": "N",
                "strength": 3
                ] as [String : Any]
            if let attack = Attack(attackJSON: json){
                XCTAssertTrue(wall.attack(attack: attack), "Attack failed. It should have succeeded")
                wall.height = 3
                XCTAssertFalse(wall.attack(attack: attack), "Attack Succeeded. It should have failed")
                
            }else{
                 XCTAssertFalse(true, "attack became nil")
            }
            
        }else{
             XCTAssertFalse(true, "Direction became nil")
        }
    }
    func testWallCreation(){
        if let direction = Direction(rawValue: "N"){
            let wall = Wall(direction: direction, height: 0)
            XCTAssertNotNil(wall, "nil wall")
            XCTAssertEqual(wall.direction, direction, "Different direction")
            XCTAssertEqual(wall.height, 0, "Different height")
            XCTAssertNotEqual(wall.height, 1, "Different height")
            XCTAssertNotEqual(wall.direction.rawValue, "W", "Same direction")
            
            
        }else{
            XCTAssertFalse(true, "Direction became nil")
        }
        
    }
    func testTribe(){
        let json = [ "name": "1" ]
        let tribe =  Tribe(tribeJSON: json)
        XCTAssertNotNil(tribe, "Invalid tribe")
        XCTAssertEqual(tribe?.tribeName, "1", "Names are different")
        XCTAssertNotEqual(tribe?.tribeName, "2", "Names are Same")

    }
    func testAttackCreation(){
    
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
    func testDayModel(){
        let json : [String : Any] = ["day" : "1",
                                     "attacks": [
                                        [
                                            "tribe": [ "name": "1" ],
                                            "direction": "N",
                                            "strength": 3
                                        ],
                                        [
                                            "tribe": [ "name": "2" ],
                                            "direction": "S",
                                            "strength": 4
                                        ],
                                        [
                                            "tribe": [ "name": "3" ],
                                            "direction": "W",
                                            "strength": 2
                                        ]
            ]
        ]
        let day = Day(dayJSON: json)
        XCTAssertNotNil(day, "Invalid JSON")
        XCTAssertEqual(day?.dayID, "1", "Invalid day ID")
        XCTAssertNotEqual(day?.dayID, "2", "Valid day ID")
        XCTAssertEqual(day?.attacks.count, 3, "Invalid attacks count")
        XCTAssertNotEqual(day?.attacks.count, 1, "Valid attacks count")
        
        let invalidJson : [String : Any] = ["day" : 1,
                                     "attacks": [
                                        [
                                            "tribe": [ "name": "1" ],
                                            "direction": "N",
                                            "strength": 3
                                        ],
                                        [
                                            "tribe": [ "name": "2" ],
                                            "direction": "S",
                                            "strength": 4
                                        ],
                                        [
                                            "tribe": [ "name": "3" ],
                                            "direction": "W",
                                            "strength": 2
                                        ]
            ]
        ]
        let invalidDay = Day(dayJSON: invalidJson)
        XCTAssertNil(invalidDay, "valid  JSON")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
