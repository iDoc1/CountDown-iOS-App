//
//  WorkoutHistoryPropertiesTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 12/7/23.
//

import XCTest
import CoreData
@testable import CountDown

final class WorkoutHistoryPropertiesTest: XCTestCase {
    var context: NSManagedObjectContext!
    var workout: Workout!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
        
        // Test grip creation
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
    }

    override func tearDownWithError() throws {
        context = nil
    }
    
    func testUnwrappedPropertiesAreCorrect() throws {
        let now = Date()
        let workoutHistory = WorkoutHistory(context: context)
        workoutHistory.totalSeconds = 423
        workoutHistory.workoutDate = now
        workoutHistory.workout = workout
        workoutHistory.notes = "Test notes"
        
        XCTAssertEqual(workoutHistory.unwrappedTotalSeconds, 423)
        XCTAssertEqual(workoutHistory.unwrappedNotes, "Test notes")
        XCTAssertEqual(workoutHistory.unwrappedWorkoutDate, now)
    }
    
    func testGripSequenceIsCorrect() throws {
        let now = Date()
        let workoutHistory = WorkoutHistory(context: context)
        workoutHistory.totalSeconds = 423
        workoutHistory.workoutDate = now
        workoutHistory.workout = workout
        
        let historyGrip1 = HistoryGrip(context: context)
        historyGrip1.workoutHistory = workoutHistory
        historyGrip1.gripTypeName = "Full Crimp"
        historyGrip1.setCount = 3
        historyGrip1.repCount = 6
        historyGrip1.workSeconds = 7
        historyGrip1.restSeconds = 3
        historyGrip1.breakMinutes = 1
        historyGrip1.breakSeconds = 30
        historyGrip1.lastBreakMinutes = 1
        historyGrip1.lastBreakSeconds = 30
        historyGrip1.sequenceNum = 2
        
        let historyGrip2 = HistoryGrip(context: context)
        historyGrip2.workoutHistory = workoutHistory
        historyGrip2.gripTypeName = "Half Crimp"
        historyGrip2.setCount = 3
        historyGrip2.repCount = 6
        historyGrip2.workSeconds = 7
        historyGrip2.restSeconds = 3
        historyGrip2.breakMinutes = 1
        historyGrip2.breakSeconds = 30
        historyGrip2.lastBreakMinutes = 1
        historyGrip2.lastBreakSeconds = 30
        historyGrip2.sequenceNum = 1
        
        
        XCTAssertEqual(workoutHistory.gripArray[0].gripTypeName, "Half Crimp")
        XCTAssertEqual(workoutHistory.gripArray[1].gripTypeName, "Full Crimp")
    }
}
