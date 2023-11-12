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
    var name = ""
    var description = ""
    var hangboardName = ""
    var workoutType = WorkoutTypeAsString.strength
    let context: NSManagedObjectContext
    
    func save() {
        let workout = Workout(context: context)
        workout.name = name
        workout.descriptionText = description
        workout.hangboardName = hangboardName
        workout.workoutType = WorkoutType(context: context)
        workout.workoutType?.name = workoutType.rawValue
        workout.createdDate = Date()
        
        do {
            try context.save()
        } catch {
            print("Failed to save Workout: \(error)")
        }
    }
}
