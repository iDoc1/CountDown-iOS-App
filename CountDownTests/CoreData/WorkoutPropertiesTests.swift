//
//  WorkoutPropertiesTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/26/23.
//

import XCTest
import CoreData
@testable import CountDown

final class WorkoutPropertiesTests: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testUnwrappedPropertiesAreCorrect() throws {
        let now = Date()
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.hangboardName = "Trango"
        workout.createdDate = now
        workout.workoutType = workoutType
        try context.save()
        
        XCTAssertEqual(workout.unwrappedName, "Repeaters")
        XCTAssertEqual(workout.unwrappedDescriptionText, "RCTM Advanced Repeaters Protocol")
        XCTAssertEqual(workout.unwrappedHangboardName, "Trango")
        XCTAssertEqual(workout.unwrappedCreatedDate, now)
        XCTAssertEqual(workout.unwrappedWorkoutTypeName, "powerEndurance")
    }
    
    func testNilPropertiesAreCorrect() throws {
        let workout = Workout(context: context)
        
        XCTAssertEqual(workout.unwrappedName, "Unknown Workout")
        XCTAssertEqual(workout.unwrappedDescriptionText, "Unknown Description")
        XCTAssertEqual(workout.unwrappedHangboardName, "None Specified")
        XCTAssertNil(workout.unwrappedCreatedDate)
        XCTAssertEqual(workout.unwrappedWorkoutTypeName, "Unknown Type")
    }
    
    func testWorkoutSavesWithoutHangboardName() throws {
        let now = Date()
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = now
        workout.workoutType = workoutType
        
        XCTAssertNoThrow(try context.save())
        XCTAssertEqual(workout.unwrappedName, "Repeaters")
        XCTAssertEqual(workout.unwrappedDescriptionText, "RCTM Advanced Repeaters Protocol")
        XCTAssertEqual(workout.unwrappedHangboardName, "None Specified")
        XCTAssertEqual(workout.unwrappedCreatedDate, now)
        XCTAssertEqual(workout.unwrappedWorkoutTypeName, "powerEndurance")
    }
    
    func testGripSequenceIsCorrect() throws {
        let now = Date()
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.hangboardName = "Trango"
        workout.createdDate = now
        workout.workoutType = workoutType
        
        let gripType1 = GripType(context: context)
        gripType1.name = "Half Crimp"
        let gripType2 = GripType(context: context)
        gripType2.name = "Three Finger Drag"
        
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 3
        grip2.repCount = 6
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 0
        grip2.lastBreakMinutes = 59
        grip2.lastBreakSeconds = 59
        grip2.edgeSize = 20
        grip2.sequenceNum = 3
        grip2.gripType = gripType2
        
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 3
        grip1.repCount = 6
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        try context.save()
        
        XCTAssertEqual(workout.maxSeqNum, 3)
        XCTAssertEqual(workout.gripArray[0].gripType?.name, "Half Crimp")
        XCTAssertEqual(workout.gripArray[1].gripType?.name, "Three Finger Drag")
    }
}
