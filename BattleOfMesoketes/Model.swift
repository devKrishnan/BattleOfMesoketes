//
//  Model.swift
//  BattleOfMesoketes
//
//  Created by radhakrishnan S on 27/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

enum Direction : String {
    case North = "N"
    case South = "S"
    case West = "W"
    case East = "E"
}


enum DataError: Error {
    case invalidDirection
    case invalidStrength
    case invalidAttackCount
    case invalidFile
    case invalidFileData
    case invalidWarData
}
//Does Tribe play a role at all in the context of solution
//Does the success depend on the consequtive attack of a single tribe
struct Tribe {
    var tribeName : String
    init?(tribeJSON: [String: Any]) {
        guard let name = tribeJSON[Constants.nameKey] as? String else {
            return nil
        }
        self.tribeName = name
    }
}
struct Attack{
    var tribe : Tribe? = nil
    let direction : Direction
    let strength : UInt
    init?(attackJSON : [String: Any]) {
        guard let direction = attackJSON[Constants.directionKey] else { return nil }
        guard let directionEnum = Direction(rawValue: direction as! String) else { return nil }
        guard let tempStrength = attackJSON[Constants.strengthKey] as? Int  else { return nil }
        
        if let tempTribe = attackJSON[Constants.tribeKey] as?  [String : Any]{
            self.tribe = Tribe(tribeJSON: tempTribe)
        }
        
        self.direction = directionEnum
        self.strength = UInt(tempStrength)
        
    }
}
struct Fort {
    private  var wallsMap : [Direction : Wall] = [:]
    var successfullAttacks : UInt = 0
    mutating func wall(inDirection direction: Direction, defaultHeight: UInt )->Wall{
        if let wall = wallsMap[direction]  {
            return wall
        }else{
            let wall = Wall(direction:direction, height: defaultHeight)
            wallsMap[direction] = wall
            return wall
        }
    }
    mutating func updateWallHeight(inDirection direction: Direction, height :  UInt){
        var currentWall = wall(inDirection: direction, defaultHeight: 0)
        currentWall.height = height
        wallsMap[direction] = currentWall
    }
    func allDirections() -> [Direction] {
        let wallsMap : [Direction] = [Direction](self.wallsMap.keys )
        return wallsMap
    }
}
struct Wall {
    var direction : Direction
    var height : UInt
    init(direction: Direction, height : UInt) {
        self.direction = direction
        self.height = height
    }
    func attackSuccess(attack : Attack) -> Bool {
        return height < attack.strength
    }
    
}
struct Day {
    var dayID : String
    var attacks : [Attack] = []
    init?(dayJSON : [String:Any]) {
        guard let tempID = dayJSON[Constants.dayKey] else { return nil }
        guard let tempAttacks = dayJSON[Constants.attacksKey] else { return nil }
        guard let dayId = tempID as? String else { return nil }
        self.dayID = dayId
        guard let attackList = tempAttacks as? [[String:Any]] else { return nil }
        for attackDict in attackList {
            if let attack = Attack(attackJSON: attackDict){
                self.attacks.append(attack)
            }else{
                return nil
            }
            
        }
    }
}
struct War {
    var days : [Day] = []
    var warID : String
    init?(warJSON : [String:Any] ) {
        
        guard let warID = warJSON[Constants.warIdKey] as? String
            else { return nil }
        guard let daysList = warJSON[Constants.warDaysKey] as? [ [String: Any] ]
            else { return nil }
      
        for dayInfo in daysList {
            if let day = Day(dayJSON: dayInfo){
                days.append(day)
            }else{
                return nil
            }
        }
        self.warID = warID
        
    }
    func initiateAttack()->UInt {
        var fort = Fort()
        //TODO:- What happens if the same Tribe attacks the same wall multiple times.
        // Lets say they attack 3 times, with same or incresing order of strength. should we consider each attack as success?
        for day in days {
            //Used to store the maximum strength applied on each direction of the wall
            var maximumStrength : [Direction:UInt] = [:]
            for attack in day.attacks {
                let wall = fort.wall(inDirection: attack.direction, defaultHeight: Constants.defaultHeightWall)
                if wall.attackSuccess(attack: attack){
                    fort.successfullAttacks = fort.successfullAttacks + 1
                    if let strength = maximumStrength[attack.direction]  {
                        if  attack.strength > strength {
                            maximumStrength[attack.direction] = attack.strength
                        }
                    }else{
                        maximumStrength[attack.direction] = attack.strength
                    }
                }
            }
            //At the end of each day, the walls height is modified according to the maximum strength used on the wall
            for direction in fort.allDirections(){
                if let strength = maximumStrength[direction] {
                    fort.updateWallHeight(inDirection: direction, height: strength)
                }
            }
            
        }
        return fort.successfullAttacks
    }
}
