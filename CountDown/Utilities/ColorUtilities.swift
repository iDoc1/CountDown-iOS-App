//
//  ColorUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI

/// Returns the color corresponding to the given workout type
/// - Parameter workoutType: The WorkoutType entity
/// - Returns: A SwiftUI Color
func getColorFromWorkoutType(workoutType: WorkoutType?) -> Color {
    let workoutType = WorkoutTypeAsString(rawValue: workoutType?.name ?? "")
    
    switch workoutType {
    case .none:
        return .white
    case .endurance:
        return Theme.lightGreen.mainColor
    case .power:
        return Theme.brightRed.mainColor
    case .strength:
        return Theme.lightBlue.mainColor
    case .powerEndurance:
        return Theme.lightOrange.mainColor
    case .other:
        return Theme.lightPurple.mainColor
    }
}
