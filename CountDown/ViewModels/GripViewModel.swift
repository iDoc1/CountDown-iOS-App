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
    var grip: Grip?
    var workout: Workout
    let context: NSManagedObjectContext
    var setCount: Int
    var repCount: Int
    var decrementSets: Bool
    var hasCustomDurations: Bool
    var workSeconds: Int
    var restSeconds: Int
    var breakMinutes: Int
    var breakSeconds: Int
    var lastBreakMinutes: Int
    var lastBreakSeconds: Int
    var sequenceNum: Int
    var edgeSize: Int?
    var gripType: GripType?
    
    /// Initilize without an existing grip
    init(workout: Workout, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.setCount = 1
        self.repCount = 1
        self.decrementSets = false
        self.hasCustomDurations = false
        self.workSeconds = 7
        self.restSeconds = 3
        self.breakMinutes = 1
        self.breakSeconds = 30
        self.lastBreakMinutes = 1
        self.lastBreakSeconds = 30
        // Ensure grip is last in the workout
        self.sequenceNum = workout.maxSeqNum + 1
        self.edgeSize = nil
        self.gripType = nil
    }
    
    /// Initialize from an existing grip
    init(workout: Workout, grip: Grip, context: NSManagedObjectContext) {
        self.grip = grip
        self.workout = workout
        self.context = context
        self.setCount = grip.unwrappedSetCount
        self.repCount = grip.unwrappedRepCount
        self.decrementSets = grip.unwrappedDecrementSets
        self.hasCustomDurations = grip.unwrappedHasCustomDurations
        self.workSeconds = grip.unwrappedWorkSeconds
        self.restSeconds = grip.unwrappedRestSeconds
        self.breakMinutes = grip.unwrappedBreakMinutes
        self.breakSeconds = grip.unwrappedBreakSeconds
        self.lastBreakMinutes = grip.unwrappedLastBreakMinutes
        self.lastBreakSeconds = grip.unwrappedLastBreakSeconds
        self.sequenceNum = grip.unwrappedSequenceNum
        self.edgeSize = grip.unwrappedEdgeSize
        self.gripType = grip.gripType
    }
    
    mutating func save() {
        if grip == nil {
            grip = Grip(context: context)
        }
        
        grip!.workout = workout
        grip!.setCount = Int16(setCount)
        grip!.repCount = Int16(repCount)
        grip!.workSeconds = Int16(workSeconds)
        grip!.restSeconds = Int16(restSeconds)
        grip!.decrementSets = decrementSets
        grip!.hasCustomDurations = hasCustomDurations
        grip!.breakMinutes = Int16(breakMinutes)
        grip!.breakSeconds = Int16(breakSeconds)
        grip!.lastBreakMinutes = Int16(lastBreakMinutes)
        grip!.lastBreakSeconds = Int16(lastBreakSeconds)
        grip!.sequenceNum = Int16(sequenceNum)
        grip!.gripType = gripType
        
        // Only set edge size if it is a positive integer
        if edgeSize != nil && edgeSize != 0 {
            grip!.edgeSize = Int16(edgeSize!)
        } else {
            grip!.edgeSize = 0
        }

        do {
            try context.save()
        } catch {
            print("Failed to save Grip: \(error)")
        }
    }
}
