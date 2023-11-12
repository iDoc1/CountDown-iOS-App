//
//  FormUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 11/12/23.
//

import SwiftUI

/// Updates the given errorMessages object based on the values of the given grip. If the grip contains validation errors, then returns
/// false. Otherwise, returns true.
/// - Parameters:
///   - grip: The GripViewModel to check for errors
///   - errorMessages: The ErrorMessages object to store the error messages in
/// - Returns: True if there are no errors. False if there are errors.
func gripIsValidated(grip: GripViewModel, errorMessages: ErrorMessages) -> Bool {
    var isValidated = true
    errorMessages.clearErrors()

    if grip.gripType == nil {
        errorMessages.addError("Grip Type must be specified")
        isValidated = false
    }

    if let edgeSize = grip.edgeSize {
        if edgeSize < 1 || edgeSize > 50 {
            errorMessages.addError("Edge size must be between 1 and 50")
            isValidated = false
        }
    }
    
    return isValidated
}

/// Updates the given errorMessages object based on the values of the given workout. If the worlout contains validation errors, then
/// returns false. Otherwise, returns true.
/// - Parameters:
///   - workout: The WorkoutViewModel to check for errors
///   - errorMessages: The ErrorMessages object to store the error messages in
/// - Returns: True if there are no errors. False if there are errors.
func workoutIsValidated(workout: WorkoutViewModel, errorMessages: ErrorMessages) -> Bool {
    var isValidated = true
    errorMessages.clearErrors()

    if workout.name.isEmpty {
        errorMessages.addError("Name field cannot be empty")
        isValidated = false
    }
    
    if workout.description.isEmpty {
        errorMessages.addError("Description field cannot be empty")
        isValidated = false
    }
    
    return isValidated
}
