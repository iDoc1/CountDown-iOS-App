//
//  GripViewModelTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/11/23.
//

import XCTest
import CoreData
@testable import CountDown

final class GripViewModelTests: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }
    
    func testGripSequenceNumbersAreCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
        
        var grip1 = GripViewModel(workout: workout, context: context)
        grip1.save()
        XCTAssertEqual(grip1.sequenceNum, 1)
        
        let grip2 = GripViewModel(workout: workout, context: context)
        XCTAssertEqual(grip2.sequenceNum, 2)
    }
    
    func testNewGripCreatedCorrectly() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Full Crimp"
        try context.save()
        
        var grip = GripViewModel(workout: workout, context: context)
        grip.setCount = 5
        grip.repCount = 6
        grip.workSeconds = 12
        grip.restSeconds = 3
        grip.breakMinutes = 2
        grip.breakSeconds = 35
        grip.lastBreakMinutes = 3
        grip.lastBreakSeconds = 45
        grip.gripType = gripType
        grip.save()
        
        let fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        let savedGrip = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedGrip?.unwrappedSetCount, 5)
        XCTAssertEqual(savedGrip?.unwrappedRepCount, 6)
        XCTAssertEqual(savedGrip?.unwrappedWorkSeconds, 12)
        XCTAssertEqual(savedGrip?.unwrappedRestSeconds, 3)
        XCTAssertEqual(savedGrip?.unwrappedBreakMinutes, 2)
        XCTAssertEqual(savedGrip?.unwrappedBreakSeconds, 35)
        XCTAssertEqual(savedGrip?.unwrappedLastBreakMinutes, 3)
        XCTAssertEqual(savedGrip?.unwrappedLastBreakSeconds, 45)
        XCTAssertEqual(savedGrip?.unwrappedEdgeSize, nil)
        XCTAssertEqual(savedGrip?.unwrappedSequenceNum, 1)
        XCTAssertEqual(savedGrip?.unwrappedGripTypeName, "Full Crimp")
    }
    
    func testEdgeSizeIsCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
        
        var grip = GripViewModel(workout: workout, context: context)
        grip.edgeSize = 12
        grip.save()
        
        let fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        let savedGrip = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedGrip?.edgeSize, 12)
    }
    
    func testNilEdgeSizeIsCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
        
        var grip = GripViewModel(workout: workout, context: context)
        grip.edgeSize = nil
        
        let fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        let savedGrip = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedGrip?.edgeSize, nil)
    }
    
    func testZeroEdgeSizeIsCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
        
        var grip = GripViewModel(workout: workout, context: context)
        grip.edgeSize = 0
        
        let fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        let savedGrip = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedGrip?.edgeSize, nil)
    }
    
    func testEditedGripIsCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        let gripType = GripType(context: context)
        gripType.name = "Full Crimp"
        try context.save()
        
        var grip = Grip(context: context)
        grip.setCount = 5
        grip.repCount = 6
        grip.workSeconds = 12
        grip.restSeconds = 3
        grip.breakMinutes = 2
        grip.breakSeconds = 35
        grip.lastBreakMinutes = 3
        grip.lastBreakSeconds = 45
        grip.gripType = gripType
        grip.workout = workout
        grip.sequenceNum = 3
        try context.save()
        
        var fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        var savedGrip = try context.fetch(fetchRequest).first
        
        var gripViewModel = GripViewModel(workout: workout, grip: savedGrip!, context: context)
        gripViewModel.setCount = 3
        gripViewModel.repCount = 4
        gripViewModel.workSeconds = 7
        gripViewModel.restSeconds = 5
        gripViewModel.breakMinutes = 1
        gripViewModel.breakSeconds = 45
        gripViewModel.lastBreakMinutes = 2
        gripViewModel.lastBreakSeconds = 35
        gripViewModel.edgeSize = 12
        gripViewModel.save()
        
        fetchRequest = NSFetchRequest<Grip>(entityName: "Grip")
        savedGrip = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedGrip?.unwrappedSetCount, 3)
        XCTAssertEqual(savedGrip?.unwrappedRepCount, 4)
        XCTAssertEqual(savedGrip?.unwrappedWorkSeconds, 7)
        XCTAssertEqual(savedGrip?.unwrappedRestSeconds, 5)
        XCTAssertEqual(savedGrip?.unwrappedBreakMinutes, 1)
        XCTAssertEqual(savedGrip?.unwrappedBreakSeconds, 45)
        XCTAssertEqual(savedGrip?.unwrappedLastBreakMinutes, 2)
        XCTAssertEqual(savedGrip?.unwrappedLastBreakSeconds, 35)
        XCTAssertEqual(savedGrip?.unwrappedEdgeSize, 12)
        XCTAssertEqual(savedGrip?.unwrappedSequenceNum, 3)
        XCTAssertEqual(savedGrip?.unwrappedGripTypeName, "Full Crimp")
    }
}