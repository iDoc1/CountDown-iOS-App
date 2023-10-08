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
    let timerDetails = TimerSetupDetails(
        sets: 2,
        reps: 3,
        workSeconds: 7,
        restSeconds: 3,
        breakMinutes: 1,
        breakSeconds: 45)
    var timer: CountdownTimer!

    override func setUpWithError() throws {
        timer = CountdownTimer(timerDetails: timerDetails)
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
