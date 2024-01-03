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
    var customWorkSeconds: [Int]
    var customRestSeconds: [Int]
    
    /// Initilize without an existing grip
    init() {
        self.setCount = 1
        self.repCount = 1
        self.decrementSets = false
        self.workSeconds = 7
        self.restSeconds = 3
        self.breakMinutes = 1
        self.breakSeconds = 30
        self.lastBreakMinutes = 1
        self.lastBreakSeconds = 30
        self.sequenceNum = 100 // Dummy value. This is changed when grip is saved.
        self.edgeSize = nil
        self.gripType = nil
        
        /// Custom durations variables
        self.hasCustomDurations = false
        self.customWorkSeconds = [Int](repeating: workSeconds, count: maxNumberOfReps)
        self.customRestSeconds = [Int](repeating: restSeconds, count: maxNumberOfReps)
    }
    
    /// Initialize from an existing grip
    init(grip: Grip) {
        self.grip = grip
        self.setCount = grip.unwrappedSetCount
        self.repCount = grip.unwrappedRepCount
        self.decrementSets = grip.unwrappedDecrementSets
        self.workSeconds = grip.unwrappedWorkSeconds
        self.restSeconds = grip.unwrappedRestSeconds
        self.breakMinutes = grip.unwrappedBreakMinutes
        self.breakSeconds = grip.unwrappedBreakSeconds
        self.lastBreakMinutes = grip.unwrappedLastBreakMinutes
        self.lastBreakSeconds = grip.unwrappedLastBreakSeconds
        self.sequenceNum = grip.unwrappedSequenceNum
        self.edgeSize = grip.unwrappedEdgeSize
        self.gripType = grip.gripType
        
        /// Custom durations variables
        self.hasCustomDurations = grip.unwrappedHasCustomDurations
        self.customWorkSeconds = grip.unwrappedCustomWork
        self.customRestSeconds = grip.unwrappedCustomRest
    }
    
    /// Saves this view model to Core Data as a new Grip entity
    mutating func saveAsGrip(workout: Workout, context: NSManagedObjectContext) {
        if grip == nil {
            grip = Grip(context: context)
            // Only set the sequenceNum when grip is first created
            grip!.sequenceNum = Int16(workout.maxSeqNum + 1)
        }
        
        grip!.workout = workout
        grip!.setCount = Int16(setCount)
        grip!.repCount = Int16(repCount)
        grip!.workSeconds = Int16(workSeconds)
        grip!.restSeconds = Int16(restSeconds)
        grip!.decrementSets = decrementSets
        grip!.breakMinutes = Int16(breakMinutes)
        grip!.breakSeconds = Int16(breakSeconds)
        grip!.lastBreakMinutes = Int16(lastBreakMinutes)
        grip!.lastBreakSeconds = Int16(lastBreakSeconds)
        grip!.gripType = gripType
        grip!.hasCustomDurations = hasCustomDurations
        grip!.customWorkSeconds = customWorkSeconds
        grip!.customRestSeconds = customRestSeconds
        
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
