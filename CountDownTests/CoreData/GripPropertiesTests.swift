//
//  GripPropertiesTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/25/23.
//

import XCTest
import CoreData
@testable import CountDown

final class GripPropertiesTests: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testUnwrappedPropertiesAreCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        try context.save()
        
        let grip = Grip(context: context)
        grip.workout = workout
        grip.gripType = gripType
        grip.setCount = 2
        grip.repCount = 6
        grip.decrementSets = false
        grip.workSeconds = 7
        grip.restSeconds = 3
        grip.breakMinutes = 1
        grip.breakSeconds = 30
        grip.lastBreakMinutes = 2
        grip.lastBreakSeconds = 15
        grip.hasCustomDurations = true
        grip.customWorkSeconds = [3, 6, 9, 12]
        grip.customRestSeconds = [30, 35, 40, 45]
        grip.edgeSize = 18
        grip.sequenceNum = 3
        try context.save()
        
        XCTAssertEqual(grip.unwrappedSetCount, 2)
        XCTAssertEqual(grip.unwrappedRepCount, 6)
        XCTAssertEqual(grip.unwrappedWorkSeconds, 7)
        XCTAssertEqual(grip.unwrappedRestSeconds, 3)
        XCTAssertEqual(grip.unwrappedBreakMinutes, 1)
        XCTAssertEqual(grip.unwrappedBreakSeconds, 30)
        XCTAssertEqual(grip.unwrappedLastBreakMinutes, 2)
        XCTAssertEqual(grip.unwrappedLastBreakSeconds, 15)
        XCTAssertEqual(grip.unwrappedDecrementSets, false)
        XCTAssertEqual(grip.unwrappedHasCustomDurations, true)
        XCTAssertEqual(grip.unwrappedCustomWork, [3, 6, 9, 12])
        XCTAssertEqual(grip.unwrappedCustomRest, [30, 35, 40, 45])
        XCTAssertEqual(grip.unwrappedEdgeSize, 18)
        XCTAssertEqual(grip.unwrappedSequenceNum, 3)
        XCTAssertEqual(grip.unwrappedGripTypeName, "Half Crimp")
    }
    
    func testUnwrappedNilPropertiesAreCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        try context.save()
        
        let grip = Grip(context: context)
        
        XCTAssertEqual(grip.unwrappedSetCount, 1)
        XCTAssertEqual(grip.unwrappedRepCount, 1)
        XCTAssertEqual(grip.unwrappedWorkSeconds, 1)
        XCTAssertEqual(grip.unwrappedRestSeconds, 1)
        XCTAssertEqual(grip.unwrappedBreakMinutes, 0)
        XCTAssertEqual(grip.unwrappedBreakSeconds, 0)
        XCTAssertEqual(grip.unwrappedLastBreakMinutes, 0)
        XCTAssertEqual(grip.unwrappedLastBreakSeconds, 0)
        XCTAssertEqual(grip.unwrappedDecrementSets, false)
        XCTAssertEqual(grip.unwrappedHasCustomDurations, false)
        XCTAssertEqual(grip.unwrappedCustomWork.count, maxNumberOfReps)
        XCTAssertEqual(grip.unwrappedCustomWork.first, 7)
        XCTAssertEqual(grip.unwrappedCustomRest.count, maxNumberOfReps)
        XCTAssertEqual(grip.unwrappedCustomRest.first, 3)
        XCTAssertNil(grip.unwrappedEdgeSize)
        XCTAssertEqual(grip.unwrappedSequenceNum, 0)
        XCTAssertEqual(grip.unwrappedGripTypeName, "Unknown Grip Type")
    }
    
    func testDuplicateGrip() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        try context.save()
        
        // Create and duplicate grip
        let grip = Grip(context: context)
        grip.workout = workout
        grip.gripType = gripType
        grip.setCount = 2
        grip.repCount = 6
        grip.decrementSets = false
        grip.workSeconds = 7
        grip.restSeconds = 3
        grip.breakMinutes = 1
        grip.breakSeconds = 30
        grip.lastBreakMinutes = 2
        grip.lastBreakSeconds = 15
        grip.hasCustomDurations = true
        grip.customWorkSeconds = [3, 6, 9, 12]
        grip.customRestSeconds = [30, 35, 40, 45]
        grip.edgeSize = 18
        grip.sequenceNum = 3
        grip.duplicate(with: context)
        try context.save()
        
        // Fetch all grips including new duplicate one
        let grips = workout.gripArray
        let dupGrip = grips.last
        
        XCTAssertEqual(grips.count, 2)
        XCTAssertEqual(dupGrip!.unwrappedSetCount, 2)
        XCTAssertEqual(dupGrip!.unwrappedRepCount, 6)
        XCTAssertEqual(dupGrip!.unwrappedWorkSeconds, 7)
        XCTAssertEqual(dupGrip!.unwrappedRestSeconds, 3)
        XCTAssertEqual(dupGrip!.unwrappedBreakMinutes, 1)
        XCTAssertEqual(dupGrip!.unwrappedBreakSeconds, 30)
        XCTAssertEqual(dupGrip!.unwrappedLastBreakMinutes, 2)
        XCTAssertEqual(dupGrip!.unwrappedLastBreakSeconds, 15)
        XCTAssertEqual(dupGrip!.unwrappedDecrementSets, false)
        XCTAssertEqual(dupGrip!.unwrappedHasCustomDurations, true)
        XCTAssertEqual(dupGrip!.unwrappedCustomWork, [3, 6, 9, 12])
        XCTAssertEqual(dupGrip!.unwrappedCustomRest, [30, 35, 40, 45])
        XCTAssertEqual(dupGrip!.unwrappedEdgeSize, 18)
        XCTAssertEqual(dupGrip!.unwrappedSequenceNum, 4)
        XCTAssertEqual(grip.unwrappedGripTypeName, "Half Crimp")
    }
    
    func testGripSavesWithOptionalPropertiesEmpty() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        try context.save()
        
        let grip = Grip(context: context)
        grip.workout = workout
        grip.gripType = gripType
        grip.setCount = 2
        grip.repCount = 6
        grip.workSeconds = 7
        grip.restSeconds = 3
        grip.breakMinutes = 1
        grip.breakSeconds = 30
        grip.lastBreakMinutes = 2
        grip.lastBreakSeconds = 15
        grip.sequenceNum = 3
        
        XCTAssertNoThrow(try context.save())
        XCTAssertEqual(grip.unwrappedSetCount, 2)
        XCTAssertEqual(grip.unwrappedRepCount, 6)
        XCTAssertEqual(grip.unwrappedWorkSeconds, 7)
        XCTAssertEqual(grip.unwrappedRestSeconds, 3)
        XCTAssertEqual(grip.unwrappedBreakMinutes, 1)
        XCTAssertEqual(grip.unwrappedBreakSeconds, 30)
        XCTAssertEqual(grip.unwrappedLastBreakMinutes, 2)
        XCTAssertEqual(grip.unwrappedLastBreakSeconds, 15)
        XCTAssertEqual(grip.unwrappedDecrementSets, false)
        XCTAssertNil(grip.unwrappedEdgeSize)
        XCTAssertEqual(grip.unwrappedSequenceNum, 3)
        XCTAssertEqual(grip.unwrappedGripTypeName, "Half Crimp")
    }
}
