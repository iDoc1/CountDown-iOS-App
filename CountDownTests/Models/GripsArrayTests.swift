//
//  GripsArrayTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/23/23.
//

import XCTest
import CoreData
@testable import CountDown

/// Test case for GripsArray created from a TimerSetupDetails object
final class GripsArrayFromTimerSetupTests: XCTestCase {

    func testDurationStatusDescription() {
        let durationStatus = GripsArray.DurationStatus(
            seconds: 7,
            durationType: .workType,
            currSet: 1,
            currRep: 1,
            startSeconds: 0)
        XCTAssertEqual(durationStatus.description, "WORK for 7 sec")
    }

    func testZeroSetsAndZeroRepsHasOneElement() {
        let timerDetails = TimerSetupDetails(
            sets: 0,
            reps: 0,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    func testZeroSetsAndOneRepHasOneElement() {
        let timerDetails = TimerSetupDetails(
            sets: 0,
            reps: 1,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    func testOneSetAndZeroRepsHasOneElement() {
        let timerDetails = TimerSetupDetails(
            sets: 1,
            reps: 0,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    func testOneSetAndOneRepsHasTwoElements() {
        let timerDetails = TimerSetupDetails(
            sets: 1,
            reps: 1,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations.count, 2)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
    }
    
    func testOneSetAndTwoRepsHasFourElements() {
        let timerDetails = TimerSetupDetails(
            sets: 1,
            reps: 2,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
    }
    
    func testTwoSetsAndOneRepHasFourElements() {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 1,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 119)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 112)
    }
    
    func testTwoSetsAndTwoRepsHasEightElements() {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 2,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 139)
        
        XCTAssertEqual(gripsArray[0].durations.count, 8)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
        
        XCTAssertEqual(gripsArray[0].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[4].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[4].startSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[5].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[5].startSeconds, 122)
        
        XCTAssertEqual(gripsArray[0].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[6].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[6].startSeconds, 129)
        
        XCTAssertEqual(gripsArray[0].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[7].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[7].startSeconds, 132)
    }
}

/// Test case for GripsArray created from a Workout object
final class GripsArrayFromWorkoutTests: XCTestCase {
    var context: NSManagedObjectContext!
    var workout: Workout!


    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
        
        // Create test workout
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType

    }

    override func tearDownWithError() throws {
        context = nil
    }
    
    /// Test for Grips = 1, Sets = 0, Reps = 0
    func testOneGripWithZeroSetsAndZeroReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 0
        grip1.repCount = 0
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        let gripsArray = GripsArray(grips: workout.gripArray)
        
        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    /// Test for Grips = 1, Sets = 0, Reps = 1
    func testOneGripWithZeroSetsAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 0
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    /// Test for Grips = 1, Sets = 1, Reps = 0
    func testOneGripWithOneSetsAndZeroReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 0
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
    }
    
    /// Test for Grips = 1, Sets = 1, Reps = 1
    func testOneGripWithOneSetAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations.count, 2)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
    }
    
    /// Test for Grips = 1, Sets = 1, Reps = 2
    func testOneGripWithOneSetAndTwoReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 2
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
    }
    
    /// Test for Grips = 1, Sets = 2, Reps = 1
    func testOneGripWithTwoSetsAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 2
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 119)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 112)
    }
    
    /// Test for Grips = 1, Sets = 2, Reps = 2
    func testOneGripWithTwoSetsAndTwoReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 2
        grip1.repCount = 2
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 139)
        
        XCTAssertEqual(gripsArray[0].durations.count, 8)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
        
        XCTAssertEqual(gripsArray[0].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[4].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[4].startSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[5].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[5].startSeconds, 122)
        
        XCTAssertEqual(gripsArray[0].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[6].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[6].startSeconds, 129)
        
        XCTAssertEqual(gripsArray[0].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[7].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[7].startSeconds, 132)
    }
    
    /// Test for Grips = 1, Sets = 3, Reps = 2
    /// Tests that both normal break and last break are implemented correctly
    func testOneGripWithThreeSetsAndOneReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 3
        grip1.repCount = 2
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1

        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 1)
        XCTAssertEqual(gripsArray.totalSeconds, 246)
        
        XCTAssertEqual(gripsArray[0].durations.count, 12)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
        
        XCTAssertEqual(gripsArray[0].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[4].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[4].startSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[5].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[5].startSeconds, 122)
        
        XCTAssertEqual(gripsArray[0].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[6].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[6].startSeconds, 129)
        
        XCTAssertEqual(gripsArray[0].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[7].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[7].startSeconds, 132)
        
        XCTAssertEqual(gripsArray[0].durations[8].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[8].currSet, 2)
        XCTAssertEqual(gripsArray[0].durations[8].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[8].startSeconds, 139)
        
        XCTAssertEqual(gripsArray[0].durations[9].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[9].currSet, 2)
        XCTAssertEqual(gripsArray[0].durations[9].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[9].startSeconds, 229)
        
        XCTAssertEqual(gripsArray[0].durations[10].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[10].currSet, 2)
        XCTAssertEqual(gripsArray[0].durations[10].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[10].startSeconds, 236)
        
        XCTAssertEqual(gripsArray[0].durations[11].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[11].currSet, 2)
        XCTAssertEqual(gripsArray[0].durations[11].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[11].startSeconds, 239)
    }
    
    /// Test for Grips = 2, Sets = 0, Reps = 0
    func testTwoGripsWithZeroSetsAndZeroReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 0
        grip1.repCount = 0
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 0
        grip2.repCount = 0
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[1].durations.count, 0)
    }
    
    /// Test for Grips = 2, Sets = 0, Reps = 1
    func testTwoGripsWithZeroSetsAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 0
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 0
        grip2.repCount = 1
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[1].durations.count, 0)
    }
    
    /// Test for Grips = 2, Sets = 1, Reps = 0
    func testTwoGripsWithOneSetAndZeroReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 0
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 1
        grip2.repCount = 0
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 150)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[1].durations.count, 1)
        XCTAssertEqual(gripsArray[1].durations[0].description, "BREAK for 135 sec")
        XCTAssertEqual(gripsArray[1].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[0].startSeconds, 15)
    }
    
    /// Test for Grips = 2, Sets = 1, Reps = 1
    func testTwoGripsWithOneSetAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 1
        grip2.repCount = 1
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 164)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 2)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].durations.count, 2)
        XCTAssertEqual(gripsArray[1].durations[0].description, "BREAK for 135 sec")
        XCTAssertEqual(gripsArray[1].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[0].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[1].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[1].startSeconds, 157)
    }
    
    /// Test for Grips = 2, Sets = 1, Reps = 2
    func testTwoGripsWithOneSetAndTwoReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 1
        grip1.repCount = 2
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 1
        grip2.repCount = 2
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 184)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
        
        XCTAssertEqual(gripsArray[1].durations.count, 4)
        XCTAssertEqual(gripsArray[1].durations[0].description, "BREAK for 135 sec")
        XCTAssertEqual(gripsArray[1].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[0].startSeconds, 32)
        
        XCTAssertEqual(gripsArray[1].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[1].startSeconds, 167)
        
        XCTAssertEqual(gripsArray[1].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[1].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[2].startSeconds, 174)
        
        XCTAssertEqual(gripsArray[1].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[3].startSeconds, 177)
    }
    
    /// Test for Grips = 2, Sets = 2, Reps = 1
    func testTwoGripsWithTwoSetsAndOneRep() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 2
        grip1.repCount = 1
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 2
        grip2.repCount = 1
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 358)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 112)
        
        XCTAssertEqual(gripsArray[1].durations.count, 4)
        XCTAssertEqual(gripsArray[1].durations[0].description, "BREAK for 135 sec")
        XCTAssertEqual(gripsArray[1].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[0].startSeconds, 119)
        
        XCTAssertEqual(gripsArray[1].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[1].startSeconds, 254)
        
        XCTAssertEqual(gripsArray[1].durations[2].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[1].durations[2].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[2].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[2].startSeconds, 261)
        
        XCTAssertEqual(gripsArray[1].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[3].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[3].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[3].startSeconds, 351)
    }
    
    /// Test for Grips = 2, Sets = 2 Reps = 2
    func testTwoGripsWithTwoSetsAndTwoReps() throws {
        // Create test grip1
        let gripType1 = GripType(context: context)
        gripType1.name = "Full Crimp"
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 2
        grip1.repCount = 2
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
        grip1.gripType = gripType1
        
        // Create test grip2
        let gripType2 = GripType(context: context)
        gripType2.name = "Half Crimp"
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 2
        grip2.repCount = 2
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 30
        grip2.lastBreakMinutes = 2
        grip2.lastBreakSeconds = 15
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray)

        XCTAssertEqual(gripsArray.count, 2)
        XCTAssertEqual(gripsArray.totalSeconds, 398)
        
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[0].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[1].workSeconds, 7)
        XCTAssertEqual(gripsArray[1].restSeconds, 3)
        XCTAssertEqual(gripsArray[1].breakMinutes, 1)
        XCTAssertEqual(gripsArray[1].breakSeconds, 30)
        XCTAssertEqual(gripsArray[1].lastBreakMinutes, 2)
        XCTAssertEqual(gripsArray[1].lastBreakSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations.count, 8)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[0].startSeconds, 0)
        
        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[1].startSeconds, 15)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[2].startSeconds, 22)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[3].startSeconds, 25)
        
        XCTAssertEqual(gripsArray[0].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[4].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[4].startSeconds, 32)
        
        XCTAssertEqual(gripsArray[0].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[5].currRep, 0)
        XCTAssertEqual(gripsArray[0].durations[5].startSeconds, 122)
        
        XCTAssertEqual(gripsArray[0].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[6].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[6].startSeconds, 129)
        
        XCTAssertEqual(gripsArray[0].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[7].currRep, 1)
        XCTAssertEqual(gripsArray[0].durations[7].startSeconds, 132)
        
        XCTAssertEqual(gripsArray[1].durations.count, 8)
        XCTAssertEqual(gripsArray[1].durations[0].description, "BREAK for 135 sec")
        XCTAssertEqual(gripsArray[1].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[0].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[0].startSeconds, 139)
        
        XCTAssertEqual(gripsArray[1].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[1].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[1].startSeconds, 274)
        
        XCTAssertEqual(gripsArray[1].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[1].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[2].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[2].startSeconds, 281)
        
        XCTAssertEqual(gripsArray[1].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[1].durations[3].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[3].startSeconds, 284)
        
        XCTAssertEqual(gripsArray[1].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[1].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[4].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[4].startSeconds, 291)
        
        XCTAssertEqual(gripsArray[1].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[5].currRep, 0)
        XCTAssertEqual(gripsArray[1].durations[5].startSeconds, 381)
        
        XCTAssertEqual(gripsArray[1].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[1].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[6].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[6].startSeconds, 388)
        
        XCTAssertEqual(gripsArray[1].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[1].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[1].durations[7].currRep, 1)
        XCTAssertEqual(gripsArray[1].durations[7].startSeconds, 391)
    }
}
