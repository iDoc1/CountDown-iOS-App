//
//  HistoryGripPropertiesTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 12/9/23.
//

import XCTest
import CoreData
@testable import CountDown

final class HistoryGripPropertiesTest: XCTestCase {
    var context: NSManagedObjectContext!
    var workoutHistory: WorkoutHistory!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
        
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        
        workoutHistory = WorkoutHistory(context: context)
        workoutHistory.totalSeconds = 423
        workoutHistory.workoutDate = Date()
        workoutHistory.workout = workout
        
        try context.save()
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testUnwrappedPropertiesAreCorrect() throws {
        let historyGrip = HistoryGrip(context: context)
        historyGrip.workoutHistory = workoutHistory
        historyGrip.gripTypeName = "Full Crimp"
        historyGrip.setCount = 3
        historyGrip.repCount = 6
        historyGrip.workSeconds = 7
        historyGrip.restSeconds = 3
        historyGrip.breakMinutes = 1
        historyGrip.breakSeconds = 30
        historyGrip.lastBreakMinutes = 1
        historyGrip.lastBreakSeconds = 30
        historyGrip.edgeSize = 18
        historyGrip.sequenceNum = 2
        
        XCTAssertEqual(historyGrip.unwrappedSetCount, 3)
        XCTAssertEqual(historyGrip.unwrappedRepCount, 6)
        XCTAssertEqual(historyGrip.unwrappedWorkSeconds, 7)
        XCTAssertEqual(historyGrip.unwrappedRestSeconds, 3)
        XCTAssertEqual(historyGrip.unwrappedBreakMinutes, 1)
        XCTAssertEqual(historyGrip.unwrappedBreakSeconds, 30)
        XCTAssertEqual(historyGrip.unwrappedLastBreakMinutes, 1)
        XCTAssertEqual(historyGrip.unwrappedLastBreakSeconds, 30)
        XCTAssertEqual(historyGrip.unwrappedEdgeSize, 18)
        XCTAssertEqual(historyGrip.unwrappedSequenceNum, 3)
        XCTAssertEqual(historyGrip.unwrappedGripTypeName, "Half Crimp")
    }
    
    func testUnwrappedNilPropertiesAreCorrect() throws {
        let historyGrip = HistoryGrip(context: context)
        historyGrip.workoutHistory = workoutHistory
        
        XCTAssertEqual(historyGrip.unwrappedSetCount, 0)
        XCTAssertEqual(historyGrip.unwrappedRepCount, 0)
        XCTAssertEqual(historyGrip.unwrappedWorkSeconds, 0)
        XCTAssertEqual(historyGrip.unwrappedRestSeconds, 0)
        XCTAssertEqual(historyGrip.unwrappedBreakMinutes, 0)
        XCTAssertEqual(historyGrip.unwrappedBreakSeconds, 0)
        XCTAssertEqual(historyGrip.unwrappedLastBreakMinutes, 0)
        XCTAssertEqual(historyGrip.unwrappedLastBreakSeconds, 0)
        XCTAssertNil(historyGrip.unwrappedEdgeSize)
        XCTAssertEqual(historyGrip.unwrappedSequenceNum, 0)
        XCTAssertEqual(historyGrip.unwrappedGripTypeName, "Unknown Grip Type")
    }
}