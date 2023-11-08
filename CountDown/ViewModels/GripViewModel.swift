//
//  GripViewModel.swift
//  CountDown
//
//  Created by Ian Docherty on 11/2/23.
//

import Foundation
import CoreData

/// A view model that contains data related to a particular Grip
struct GripViewModel {
    var setCount = 1
    var repCount = 1
    var workSeconds = 7
    var restSeconds = 3
    var breakMinutes = 1
    var breakSeconds = 30
    var lastBreakMinutes = 1
    var lastBreakSeconds = 30
    var sequenceNum = 50 // Workouts will never have 50 grips in a real-life scenario
    var edgeSize: Int? = nil
    var gripType: GripType? = nil
    let workout: Workout
    let context: NSManagedObjectContext
    
    func save() {
        let grip = Grip(context: context)
        grip.setCount = Int16(setCount)
        grip.repCount = Int16(repCount)
        grip.workSeconds = Int16(workSeconds)
        grip.restSeconds = Int16(restSeconds)
        grip.breakMinutes = Int16(breakMinutes)
        grip.breakSeconds = Int16(breakSeconds)
        grip.lastBreakMinutes = Int16(lastBreakMinutes)
        grip.lastBreakSeconds = Int16(lastBreakSeconds)
        // Ensure sequence number is the largest in the workout so this grip is last in the order
        grip.sequenceNum = Int16(workout.maxSeqNum + 1)
        
        if let edgeSize = edgeSize {
            grip.edgeSize = Int16(edgeSize)
        }
        
        grip.gripType = gripType
        grip.workout = workout
        
        try? context.save()
    }
}
