//
//  CountdownTimerTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/25/23.
//

import XCTest
@testable import CountDown

final class CountdownTimerTests: XCTestCase {
    let timerDetails = TimerSetupDetails(
        sets: 2,
        reps: 3,
        workSeconds: 7,
        restSeconds: 3,
        breakMinutes: 1,
        breakSeconds: 45)
    var timer: CountdownTimer!

    @MainActor override func setUpWithError() throws {
        timer = CountdownTimer(timerDetails: timerDetails)
    }
    
    @MainActor override func tearDownWithError() throws {
        timer.timerState = .notStarted
    }

    @MainActor func testCountdownTimerInitialState()  {
        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.secondsElapsed, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    @MainActor func testTimerStartsCorrectly()  {
        timer.timerState = .started
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        XCTAssertEqual(timer.secondsLeft, 14)
        XCTAssertEqual(timer.timerString, "0:14")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    @MainActor func testTimerPausesCorrectly()  {
        timer.timerState = .started
        let waitExp = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [waitExp], timeout: 1.5)
        
        // Pause timer and wait 1 seconds
        timer.timerState = .paused
        let pauseExp = expectation(description: "Pause timer for 1 second")
        _ = XCTWaiter.wait(for: [pauseExp], timeout: 1.0)
        
        XCTAssertEqual(timer.secondsLeft, 14)
        XCTAssertEqual(timer.timerString, "0:14")
        XCTAssertEqual(timer.timerState, .paused)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    @MainActor func testTimerResumesCorrectly()  {
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
        XCTAssertEqual(timer.timerState, .resumed)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
    }
    
    @MainActor func testTimerResetsToInitialState()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        timer.timerState = .notStarted

        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.secondsElapsed, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
    
    @MainActor func testTimerSkipsToWorkDuration()  {
        timer.timerState = .started
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 1)
        XCTAssertEqual(timer.secondsLeft, 6)
        XCTAssertEqual(timer.timerString, "0:06")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.workType.rawValue)
    }
    
    @MainActor func testTimerSkipsToRestDuration()  {
        timer.timerState = .started
        timer.skip()
        timer.skip()
        let expectation = expectation(description: "Let timer run for 1.5 seconds")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.5)
        
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 2)
        XCTAssertEqual(timer.secondsLeft, 2)
        XCTAssertEqual(timer.timerString, "0:02")
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.restType.rawValue)
    }
    
    @MainActor func testTimerSkipsToBreakDuration()  {
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
        XCTAssertEqual(timer.timerState, .started)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.breakType.rawValue)
    }
    
    @MainActor func testTimerSkipsToCompletion()  {
        timer.timerState = .started
        for _ in 0..<12 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 1)
        XCTAssertEqual(timer.durationIndex, 12)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    @MainActor func testTimerSkipsPastCompletionWithoutError()  {
        timer.timerState = .started
        // Try skipping beyond the end of the grips array
        for _ in 0..<20 {
            timer.skip()
        }
        
        XCTAssertEqual(timer.gripIndex, 1)
        XCTAssertEqual(timer.durationIndex, 12)
        XCTAssertEqual(timer.secondsLeft, 0)
        XCTAssertEqual(timer.timerString, "0:00")
        XCTAssertEqual(timer.timerState, .completed)
        XCTAssertEqual(timer.durationType, "COMPLETE")
    }
    
    @MainActor func testTimerResetsToInitialStateAfterCompletion()  {
        timer.timerState = .started
        for _ in 0..<12 {
            timer.skip()
        }
        timer.timerState = .notStarted

        XCTAssertEqual(timer.secondsLeft, 15)
        XCTAssertEqual(timer.progress, 1.0)
        XCTAssertEqual(timer.gripIndex, 0)
        XCTAssertEqual(timer.durationIndex, 0)
        XCTAssertEqual(timer.secondsElapsed, 0)
        XCTAssertEqual(timer.timerString, "0:15")
        XCTAssertEqual(timer.timerColor, Theme.lightBlue.mainColor)
        XCTAssertEqual(timer.durationType, GripsArray.DurationType.prepareType.rawValue)
        XCTAssertEqual(timer.timerState, .notStarted)
    }
}
