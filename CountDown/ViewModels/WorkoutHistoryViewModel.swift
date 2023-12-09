//
//  HistoryViewModel.swift
//  CountDown
//
//  Created by Ian Docherty on 11/29/23.
//

import Foundation
import CoreData

struct WorkoutHistoryViewModel {
    var workoutHistory: WorkoutHistory?
    let context: NSManagedObjectContext
    var workout: Workout
    var totalSeconds: Int
    var workoutDate: Date
    var notes: String
    
    /// Initalize from existing workout history
    init (workoutHistory: WorkoutHistory, context: NSManagedObjectContext) {
        self.workoutHistory = workoutHistory
        self.workout = workoutHistory.workout!
        self.context = context
        self.totalSeconds = workoutHistory.unwrappedTotalSeconds
        self.workoutDate = workoutHistory.unwrappedWorkoutDate
        self.notes = workoutHistory.unwrappedNotes
    }
    
    /// Initialize without an existing workout history
    init(workout: Workout, totalSeconds: Int, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.totalSeconds = totalSeconds
        self.workoutDate = Date()
        self.notes = ""
    }
    
    mutating func save() {
        // Create new history if it does not already exist
        if workoutHistory == nil {
            workoutHistory = WorkoutHistory(context: context)
            workoutHistory!.workout = workout
            workoutHistory!.totalSeconds = Int16(totalSeconds)
            workoutHistory!.workoutDate = workoutDate
            
            // Create a new HistoryGrip for each grip in the workout
            for grip in workout.gripArray {
                let historyGrip = HistoryGrip(context: context)
                historyGrip.workoutHistory = workoutHistory
                historyGrip.gripTypeName = grip.gripType?.name
                historyGrip.setCount = grip.setCount
                historyGrip.repCount = grip.repCount
                historyGrip.workSeconds = grip.workSeconds
                historyGrip.restSeconds = grip.restSeconds
                historyGrip.breakMinutes = grip.breakMinutes
                historyGrip.breakSeconds = grip.breakSeconds
                historyGrip.lastBreakMinutes = grip.lastBreakMinutes
                historyGrip.lastBreakSeconds = grip.lastBreakSeconds
                historyGrip.edgeSize = grip.edgeSize
                historyGrip.sequenceNum = grip.sequenceNum
            }
        }
        
        // Always update notes because that can be modified by user
        workoutHistory!.notes = notes
        
        do {
            try context.save()
        } catch {
            print("Failed to save History: \(error)")
        }
    }
}
