//
//  HistoryGripViewModelTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 12/4/23.
//

import XCTest
import CoreData
@testable import CountDown

final class WorkoutHistoryViewModelTests: XCTestCase {
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
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 3
        grip1.repCount = 6
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 1
        grip1.lastBreakSeconds = 30
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 2
        grip2.repCount = 5
        grip2.workSeconds = 9
        grip2.restSeconds = 4
        grip2.breakMinutes = 1
        grip2.breakSeconds = 45
        grip2.lastBreakMinutes = 1
        grip2.lastBreakSeconds = 45
        grip2.edgeSize = 16
        grip2.sequenceNum = 2
        grip2.gripType = gripType2
        
        try context.save()
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testWorkoutHistoryCreatedCorrectlyFromWorkout() throws {
        var workoutHistory = WorkoutHistoryViewModel(
            workout: workout,
            totalSeconds: 423,
            context: context)
        workoutHistory.save()
        
        let fetchRequest = NSFetchRequest<WorkoutHistory>(entityName: "WorkoutHistory")
        let savedHistory = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedHistory?.totalSeconds, 423)
        XCTAssertEqual(savedHistory?.notes, "")
        XCTAssertEqual(savedHistory?.gripArray.count, 2)
        
        XCTAssertEqual(savedHistory?.gripArray[0].setCount, 3)
        XCTAssertEqual(savedHistory?.gripArray[0].repCount, 6)
        XCTAssertEqual(savedHistory?.gripArray[0].workSeconds, 7)
        XCTAssertEqual(savedHistory?.gripArray[0].restSeconds, 3)
        XCTAssertEqual(savedHistory?.gripArray[0].breakMinutes, 1)
        XCTAssertEqual(savedHistory?.gripArray[0].breakSeconds, 30)
        XCTAssertEqual(savedHistory?.gripArray[0].lastBreakMinutes, 1)
        XCTAssertEqual(savedHistory?.gripArray[0].lastBreakSeconds, 30)
        XCTAssertEqual(savedHistory?.gripArray[0].edgeSize, 18)
        XCTAssertEqual(savedHistory?.gripArray[0].sequenceNum, 1)
        XCTAssertEqual(savedHistory?.gripArray[0].gripTypeName, "Full Crimp")
        
        XCTAssertEqual(savedHistory?.gripArray[1].setCount, 2)
        XCTAssertEqual(savedHistory?.gripArray[1].repCount, 5)
        XCTAssertEqual(savedHistory?.gripArray[1].workSeconds, 9)
        XCTAssertEqual(savedHistory?.gripArray[1].restSeconds, 4)
        XCTAssertEqual(savedHistory?.gripArray[1].breakMinutes, 1)
        XCTAssertEqual(savedHistory?.gripArray[1].breakSeconds, 45)
        XCTAssertEqual(savedHistory?.gripArray[1].lastBreakMinutes, 1)
        XCTAssertEqual(savedHistory?.gripArray[1].lastBreakSeconds, 45)
        XCTAssertEqual(savedHistory?.gripArray[1].edgeSize, 16)
        XCTAssertEqual(savedHistory?.gripArray[1].sequenceNum, 2)
        XCTAssertEqual(savedHistory?.gripArray[1].gripTypeName, "Half Crimp")
    }
    
    func testWorkoutHistoryNotesModifiedCorrectly() throws {
        var workoutHistory = WorkoutHistoryViewModel(
            workout: workout,
            totalSeconds: 423,
            context: context)
        workoutHistory.save()
        
        var fetchRequest = NSFetchRequest<WorkoutHistory>(entityName: "WorkoutHistory")
        var savedHistory = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedHistory?.notes, "")
        
        workoutHistory.notes = "Test notes"
        workoutHistory.save()
        
        fetchRequest = NSFetchRequest<WorkoutHistory>(entityName: "WorkoutHistory")
        savedHistory = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedHistory?.notes, "Test notes")
    }
}
