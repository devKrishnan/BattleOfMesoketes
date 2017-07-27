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
