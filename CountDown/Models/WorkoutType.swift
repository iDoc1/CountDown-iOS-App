//
//  WorkoutType.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import Foundation

/// All the the available workout types for the app
enum WorkoutTypeAsString: String, CaseIterable, Identifiable {
    case power
    case endurance
    case strength
    case powerEndurance
    case other
    
    var displayName: String {
        switch self {
        case .power:
            return "Power"
        case .endurance:
            return "Endurance"
        case .strength:
            return "Strength"
        case .powerEndurance:
            return "Power Endurance"
        case .other:
            return "Other"
        }
    }
    
    var id: String {
        rawValue
    }
}
