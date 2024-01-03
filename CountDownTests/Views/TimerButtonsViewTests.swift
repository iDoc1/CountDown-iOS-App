//
//  TimerButtonsViewTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 10/7/23.
//

import XCTest
import ViewInspector
@testable import CountDown

@MainActor
final class TimerButtonsViewTests: XCTestCase {
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

    func testInitialStateHasStartButton() throws {
        let view = TimerButtonsView(timer: timer)
        XCTAssertNoThrow(try view.inspect().find(button: "Start"))
    }
    
    func testStartButtonStartsTimer() throws {
        let view = TimerButtonsView(timer: timer)
        try view.inspect().find(button: "Start").tap()
        XCTAssertEqual(timer.timerState, .started)
    }
    
    func testPauseButtonPausesTimer() throws {
        timer.timerState = .started
        let view = TimerButtonsView(timer: timer)
        try view.inspect().find(button: "Pause").tap()
        XCTAssertEqual(timer.timerState, .paused)
    }
    
    func testResetButtonResetsTimer() throws {
        timer.timerState = .started
        let view = TimerButtonsView(timer: timer)
        try view.inspect().find(button: "Reset").tap()
        XCTAssertNoThrow(try view.inspect().find(button: "Start"))
    }
    
    func testButtonLayoutChangesWhenTimerStarted() throws {
        timer.timerState = .started
        let view = TimerButtonsView(timer: timer)
        XCTAssertNoThrow(try view.inspect().find(button: "Pause"))
        XCTAssertNoThrow(try view.inspect().find(button: "Reset"))
        XCTAssertNoThrow(try view.inspect().find(button: "Skip"))
        XCTAssertThrowsError(try view.inspect().find(button: "Start"))
    }
    
    func testButtonLayoutChangesWhenTimerPaused() throws {
        timer.timerState = .started
        timer.timerState = .paused
        let view = TimerButtonsView(timer: timer)
        XCTAssertNoThrow(try view.inspect().find(button: "Resume"))
        XCTAssertNoThrow(try view.inspect().find(button: "Reset"))
        XCTAssertNoThrow(try view.inspect().find(button: "Skip"))
        XCTAssertThrowsError(try view.inspect().find(button: "Start"))
    }
    
    func testButtonLayoutChangesWhenTimerComplete() throws {
        timer.timerState = .started
        timer.timerState = .completed
        let view = TimerButtonsView(timer: timer)
        XCTAssertNoThrow(try view.inspect().find(button: "Start"))
    }
}
