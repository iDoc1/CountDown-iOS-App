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
    
    init(workout: Workout, totalSeconds: Int, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        self.totalSeconds = totalSeconds
        self.workoutDate = Date()
    }
    
    mutating func save() {
        if workoutHistory == nil {
            workoutHistory = WorkoutHistory(context: context)
        }
        
        workoutHistory!.workout = workout
        workoutHistory!.totalSeconds = Int16(totalSeconds)
        workoutHistory!.workoutDate = workoutDate
        
        // Create a new HistoryGrip for each grip in the workout
        for grip in workout.gripArray {
            let historyGrip = HistoryGrip(context: context)
            historyGrip.workoutHistory = workoutHistory
            historyGrip.setCount = grip.setCount
            historyGrip.repCount = grip.repCount
            historyGrip.workSeconds = grip.workSeconds
            historyGrip.restSeconds = grip.restSeconds
            historyGrip.breakMinutes = grip.breakMinutes
            historyGrip.breakSeconds = grip.breakSeconds
            historyGrip.edgeSize = grip.edgeSize
            historyGrip.sequenceNum = grip.sequenceNum
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save History: \(error)")
        }
    }
}
