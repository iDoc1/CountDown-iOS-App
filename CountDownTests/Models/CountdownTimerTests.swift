//
//  CountdownTimerTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/25/23.
//

import XCTest
@testable import CountDown

@MainActor
final class CountdownTimerTests: XCTestCase {
    var gripModel = GripViewModel()
    var timer: CountdownTimer!
    
    override func setUpWithError() throws {
        gripModel.setCount = 2
        gripModel.repCount = 3
        gripModel.workSeconds = 7
        gripModel.restSeconds = 3
        gripModel.breakMinutes = 1
        gripModel.breakSeconds = 45
        let gripsArray = GripsArray(grip: gripModel)
        timer = CountdownTimer(gripsArray: gripsArray)
    }
    
    override func tearDownWithError() throws {
        timer.timerState = .notStarted
    }
    
    func testCountdownTimerInitialState()  {
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "2:54")
        XCTAssertEqual(timer.timeLeft, "2:54")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    func testTimerStartsCorrectly()  {
        timer.timerState = .started
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        XCTAssertEqual(timer.secondsLeft, 14)
        XCTAssertEqual(timer.timerString, "0:14")
        XCTAssertEqual(timer.timeLeft, "2:53")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    func testTimerPausesCorrectly()  {
        timer.timerState = .started
        let waitExp = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [waitExp], timeout: 1.5)
        
        // Pause timer and wait 1 seconds
        timer.timerState = .paused
        let pauseExp = expectation(description: "Pause timer for 1 second")
        _ = XCTWaiter.wait(for: [pauseExp], timeout: 1.0)
        
        XCTAssertEqual(timer.secondsLeft, 14)
        XCTAssertEqual(timer.timerString, "0:14")
        XCTAssertEqual(timer.timeLeft, "2:53")
        XCTAssertEqual(timer.timerState, .paused)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    func testTimerResumesCorrectly()  {
        timer.timerState = .started
        let waitExp = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [waitExp], timeout: 1.5)
        
        // Pause timer and wait 1 seconds
        timer.timerState = .paused
        let pauseExp = expectation(description: "Pause timer for 1 second")
        _ = XCTWaiter.wait(for: [pauseExp], timeout: 1.0)
        
        timer.timerState = .resumed
        let resumeExp = expectation(description: "Resume timer for 1 second")
        _ = XCTWaiter.wait(for: [resumeExp], timeout: 1.0)
        
        XCTAssertEqual(timer.secondsLeft, 13)
        XCTAssertEqual(timer.timerString, "0:13")
        XCTAssertEqual(timer.timeLeft, "2:52")
        XCTAssertEqual(timer.timerState, .resumed)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    func testTimerResetsToInitialState()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        timer.timerState = .notStarted
        
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "2:54")
        XCTAssertEqual(timer.timeLeft, "2:54")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    func testTimerSkipsToWorkDuration()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 1)
        XCTAssertEqual(timer.secondsLeft, 6)
        XCTAssertEqual(timer.timerString, "0:06")
        XCTAssertEqual(timer.timeLeft, "2:38")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.workType.rawValue)
    }
    
    func testTimerSkipsToRestDuration()  {
        timer.timerState = .started
        timer.skip()
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 2)
        XCTAssertEqual(timer.secondsLeft, 2)
        XCTAssertEqual(timer.timerString, "0:02")
        XCTAssertEqual(timer.timeLeft, "2:31")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.restType.rawValue)
    }
    
    func testTimerSkipsToBreakDuration()  {
        timer.timerState = .started
        for _ in 0..<6 {
            timer.skip()
        }
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 6)
        XCTAssertEqual(timer.secondsLeft, 104)
        XCTAssertEqual(timer.timerString, "1:44")
        XCTAssertEqual(timer.timeLeft, "2:11")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.breakType.rawValue)
    }
    
    func testTimerSkipsToCompletion()  {
        timer.timerState = .started
        for _ in 0..<12 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 1)
        XCTAssertEqual(timer.durationIndex, 12)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timeLeft, "0:00")
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    func testTimerSkipsPastCompletionWithoutError()  {
        timer.timerState = .started
        // Try skipping beyond the end of the grips array
        for _ in 0..<20 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 1)
        XCTAssertEqual(timer.durationIndex, 12)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timeLeft, "0:00")
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    func testTimerResetsToInitialStateAfterCompletion()  {
        timer.timerState = .started
        for _ in 0..<12 {
            timer.skip()
        }
        timer.timerState = .notStarted
        
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "2:54")
        XCTAssertEqual(timer.timeLeft, "2:54")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
}

/// This test case tests scenarios specific to a CountdownTimer created from a workout
@MainActor
final class CountdownTimerFromWorkoutTests: XCTestCase {
    var timer: CountdownTimer!
    
    override func setUpWithError() throws {
        let context = PersistenceController(inMemory: true).container.viewContext
        
        // Create test workout
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType

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
        grip1.sequenceNum = 0
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
        grip2.sequenceNum = 1
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray, workout: workout)
        
        timer = CountdownTimer(gripsArray: gripsArray)
    }
    
    override func tearDownWithError() throws {
        timer.timerState = .notStarted
    }
    
    func testCountdownTimerInitialState()  {
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "6:38")
        XCTAssertEqual(timer.timeLeft, "6:38")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    func testTimerResetsToInitialState()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        timer.timerState = .notStarted
        
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "6:38")
        XCTAssertEqual(timer.timeLeft, "6:38")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    func testTimerSkipsToWorkDuration()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 1)
        XCTAssertEqual(timer.secondsLeft, 6)
        XCTAssertEqual(timer.timerString, "0:06")
        XCTAssertEqual(timer.timeLeft, "6:22")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.workType.rawValue)
    }
    
    func testTimerSkipsToRestDuration()  {
        timer.timerState = .started
        timer.skip()
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 2)
        XCTAssertEqual(timer.secondsLeft, 2)
        XCTAssertEqual(timer.timerString, "0:02")
        XCTAssertEqual(timer.timeLeft, "6:15")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.restType.rawValue)
    }
    
    func testTimerSkipsToBreakDuration()  {
        timer.timerState = .started
        for _ in 0..<4 {
            timer.skip()
        }
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 4)
        XCTAssertEqual(timer.secondsLeft, 89)
        XCTAssertEqual(timer.timerString, "1:29")
        XCTAssertEqual(timer.timeLeft, "6:05")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.breakType.rawValue)
    }
    
    func testTimerSkipsToLastBreakDurationOnSecondGrip()  {
        timer.timerState = .started
        for _ in 0..<8 {
            timer.skip()
        }
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 1)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.secondsLeft, 134)
        XCTAssertEqual(timer.timerString, "2:14")
        XCTAssertEqual(timer.timeLeft, "4:18")
        XCTAssertEqual(timer.currGrip.name, "Half Crimp")
        XCTAssertNil(timer.nextGrip)
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.breakType.rawValue)
    }
    
    func testTimerSkipsToCompletion()  {
        timer.timerState = .started
        for _ in 0..<16 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 2)
        XCTAssertEqual(timer.durationIndex, 8)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timeLeft, "0:00")
        XCTAssertEqual(timer.currGrip.name, "Half Crimp")
        XCTAssertNil(timer.nextGrip)
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    func testTimerSkipsPastCompletionWithoutError()  {
        timer.timerState = .started
        // Try skipping beyond the end of the grips array
        for _ in 0..<20 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 2)
        XCTAssertEqual(timer.durationIndex, 8)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timeLeft, "0:00")
        XCTAssertEqual(timer.currGrip.name, "Half Crimp")
        XCTAssertNil(timer.nextGrip)
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    func testTimerResetsToInitialStateAfterCompletion()  {
        timer.timerState = .started
        for _ in 0..<16 {
            timer.skip()
        }
        timer.timerState = .notStarted
        
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "6:38")
        XCTAssertEqual(timer.timeLeft, "6:38")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
}


/// This test case tests scenarios specific to a CountdownTimer created from a workout that has left/right mode enabled
@MainActor
final class CountdownTimerFromWorkoutWithLeftRightModeTests: XCTestCase {
    var timer: CountdownTimer!
    
    override func setUpWithError() throws {
        let context = PersistenceController(inMemory: true).container.viewContext
        
        // Create test workout
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        workout.isLeftRightEnabled = true
        workout.startHand = Hand.right.rawValue
        
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
        grip1.sequenceNum = 0
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
        grip2.sequenceNum = 1
        grip2.gripType = gripType2
        
        let gripsArray = GripsArray(grips: workout.gripArray, workout: workout)
        
        timer = CountdownTimer(gripsArray: gripsArray)
    }
    
    override func tearDownWithError() throws {
        timer.timerState = .notStarted
    }
    
    func testCountdownTimerInitialState()  {
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "8:54")
        XCTAssertEqual(timer.timeLeft, "8:54")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
        XCTAssertEqual(timer.hand, .right)
    }
    
    func testTimerResetsToInitialState()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        timer.timerState = .notStarted
        
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.totalTime, "8:54")
        XCTAssertEqual(timer.timeLeft, "8:54")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
        XCTAssertEqual(timer.hand, .right)
    }
    
    func testTimerSkipsToSwitchDuration()  {
        timer.timerState = .started
        timer.skip()
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 2)
        XCTAssertEqual(timer.secondsLeft, 9)
        XCTAssertEqual(timer.timerString, "0:09")
        XCTAssertEqual(timer.timeLeft, "8:31")
        XCTAssertEqual(timer.currGrip.name, "Full Crimp")
        XCTAssertEqual(timer.nextGrip?.name, "Half Crimp")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.switchType.rawValue)
        XCTAssertEqual(timer.hand, .left)
    }
}
