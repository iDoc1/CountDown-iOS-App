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
    var grip: Grip
    let context: NSManagedObjectContext
    var setCount: Int
    var repCount: Int
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
        self.grip = Grip(context: context)
        self.grip.workout = workout
        self.context = context
        self.setCount = 1
        self.repCount = 1
        self.workSeconds = 7
        self.restSeconds = 3
        self.breakMinutes = 1
        self.breakSeconds = 30
        self.lastBreakMinutes = 1
        self.lastBreakSeconds = 30
        self.sequenceNum = workout.maxSeqNum
        self.edgeSize = nil
        self.gripType = nil
    }
    
    /// Initialize from an existing grip
    init(workout: Workout, grip: Grip, context: NSManagedObjectContext) {
        self.grip = grip
        self.context = context
        self.setCount = grip.unwrappedSetCount
        self.repCount = grip.unwrappedRepCount
        self.workSeconds = grip.unwrappedWorkSeconds
        self.restSeconds = grip.unwrappedRestSeconds
        self.breakMinutes = grip.unwrappedBreakMinutes
        self.breakSeconds = grip.unwrappedBreakSeconds
        self.lastBreakMinutes = grip.unwrappedLastBreakMinutes
        self.lastBreakSeconds = grip.unwrappedLastBreakSeconds
        self.sequenceNum = workout.maxSeqNum
        self.edgeSize = grip.unwrappedEdgeSize
        self.gripType = grip.gripType
    }
    
    func save() {
        grip.setCount = Int16(setCount)
        grip.repCount = Int16(repCount)
        grip.workSeconds = Int16(workSeconds)
        grip.restSeconds = Int16(restSeconds)
        grip.breakMinutes = Int16(breakMinutes)
        grip.breakSeconds = Int16(breakSeconds)
        grip.lastBreakMinutes = Int16(lastBreakMinutes)
        grip.lastBreakSeconds = Int16(lastBreakSeconds)
        grip.gripType = gripType
        
        // Only set edge size if it is a positive integer
        if edgeSize != nil && edgeSize != 0 {
            grip.edgeSize = Int16(edgeSize!)
        } else {
            grip.edgeSize = 0
        }

        try? context.save()
    }
}
