//
//  WorkoutViewModel.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import Foundation
import CoreData

/// A view model that contains data related to a particular Workout
struct WorkoutViewModel: Equatable {
    var workout: Workout?
    var name: String
    var description: String
    var hangboardName: String
    var workoutType: WorkoutTypeAsString
    var isLeftRightEnabled: Bool
    var startHand: String
    var secondsBetweenHands: Int
    let context: NSManagedObjectContext
    
    /// Initialize without an existing workout
    init(context: NSManagedObjectContext) {
        self.context = context
        self.name = ""
        self.description = ""
        self.hangboardName = ""
        self.isLeftRightEnabled = false
        self.startHand = "Left"
        self.secondsBetweenHands = 10
        self.workoutType = WorkoutTypeAsString.strength
    }
    
    /// Initialized from an existing workout
    init(workout: Workout, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.name = workout.unwrappedName
        self.description = workout.unwrappedDescriptionText
        self.hangboardName = workout.unwrappedHangboardName
        self.isLeftRightEnabled = workout.unwrappedIsLeftRightEnabled
        self.startHand = workout.unwrappedStartHand
        self.secondsBetweenHands = workout.unwrappedSecondsBetweenHands
        self.workoutType = WorkoutTypeAsString(rawValue: workout.workoutType!.name ?? "") ?? .other
    }
    
    mutating func save() {
        if workout == nil {
            workout = Workout(context: context)
        }

        workout!.name = name
        workout!.descriptionText = description
        workout!.hangboardName = hangboardName
        workout!.workoutType = WorkoutType(context: context)
        workout!.workoutType?.name = workoutType.rawValue
        workout!.isLeftRightEnabled = isLeftRightEnabled
        workout!.startHand = startHand
        workout!.secondsBetweenHands = Int16(secondsBetweenHands)
        
        // Validate that secondsBetweenHands is within the valid 1 to 60 range
        if workout!.secondsBetweenHands < 1 {
            workout!.secondsBetweenHands = 1
        }
        if workout!.secondsBetweenHands > 60 {
            workout!.secondsBetweenHands = 60
        }
        
        // Do not change the workout created date if it is already set
        if workout!.unwrappedCreatedDate == nil {
            workout!.createdDate = Date()
        }

        do {
            try context.save()
        } catch {
            print("Failed to save Workout: \(error)")
        }
    }
}
