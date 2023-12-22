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
    var customWorkSeconds: [Int]
    var customRestSeconds: [Int]
    
    /// Initilize without an existing grip
    init(workout: Workout, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.setCount = 1
        self.repCount = 1
        self.decrementSets = false
        self.workSeconds = 7
        self.restSeconds = 3
        self.breakMinutes = 1
        self.breakSeconds = 30
        self.lastBreakMinutes = 1
        self.lastBreakSeconds = 30
        // Ensure grip is last in the workout by setting sequenceNum as maximum
        self.sequenceNum = workout.maxSeqNum + 1
        self.edgeSize = nil
        self.gripType = nil
        
        /// Custom durations variables
        self.hasCustomDurations = false
        self.customWorkSeconds = []
        self.customRestSeconds = []
    }
    
    /// Initialize from an existing grip
    init(workout: Workout, grip: Grip, context: NSManagedObjectContext) {
        self.grip = grip
        self.workout = workout
        self.context = context
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
    
    
    /// Takes the custom work and rest seconds arrays and initializes them with default values at and with array lengths equal to the
    /// number of reps. For example, if there are 3 reps and a defaultWork of 7 is provided then the customWorkSeconds array will
    /// look like: [7, 7, 7]
    /// - Parameters:
    ///   - defaultWork: Default work seconds to build array with
    ///   - defaultRest: Default rest seconds to build array with
    mutating func initializeCustomDurations(defaultWork: Int, defaultRest: Int) {
        customWorkSeconds = []
        customRestSeconds = []
        
        for _ in 0..<repCount {
            customWorkSeconds.append(defaultWork)
            customRestSeconds.append(defaultRest)
        }
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
        grip!.breakMinutes = Int16(breakMinutes)
        grip!.breakSeconds = Int16(breakSeconds)
        grip!.lastBreakMinutes = Int16(lastBreakMinutes)
        grip!.lastBreakSeconds = Int16(lastBreakSeconds)
        grip!.sequenceNum = Int16(sequenceNum)
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
