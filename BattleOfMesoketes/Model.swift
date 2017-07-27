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
struct Wall {
    var direction : Direction
    var height : UInt
    init(direction: Direction, height : UInt) {
        self.direction = direction
        self.height = height
    }
    func attack(attack : Attack) -> Bool {
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
