//
//  WorkoutViewModel.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import Foundation
import CoreData

/// A view model that contains data related to a particular Workout
struct WorkoutViewModel {
    var workout: Workout?
    var name: String
    var description: String
    var hangboardName: String
    var workoutType: WorkoutTypeAsString
    let context: NSManagedObjectContext
    
    /// Initialize without an existing workout
    init(context: NSManagedObjectContext) {
        self.context = context
        self.name = ""
        self.description = ""
        self.hangboardName = ""
        self.workoutType = WorkoutTypeAsString.strength
    }
    
    /// Initialized from an existing workout
    init(workout: Workout, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.name = workout.unwrappedName
        self.description = workout.unwrappedDescriptionText
        self.hangboardName = workout.unwrappedHangboardName
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
