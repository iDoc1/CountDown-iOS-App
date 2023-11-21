//
//  TimerSetupDetailsTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/24/23.
//

import XCTest
@testable import CountDown

final class TimerSetupDetailsTests: XCTestCase {
    
    func testInitialValuesCorrect() {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        XCTAssertEqual(timerDetails.sets, 2)
        XCTAssertEqual(timerDetails.reps, 3)
        XCTAssertEqual(timerDetails.workSeconds, 7)
        XCTAssertEqual(timerDetails.restSeconds, 3)
        XCTAssertEqual(timerDetails.breakMinutes, 1)
        XCTAssertEqual(timerDetails.breakSeconds, 30)
    }
    
    func testValuesCorrectWithLastBreak() {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30,
            lastBreakMinutes: 2,
            lastBreakSeconds: 45)
        XCTAssertEqual(timerDetails.sets, 2)
        XCTAssertEqual(timerDetails.reps, 3)
        XCTAssertEqual(timerDetails.workSeconds, 7)
        XCTAssertEqual(timerDetails.restSeconds, 3)
        XCTAssertEqual(timerDetails.breakMinutes, 1)
        XCTAssertEqual(timerDetails.breakSeconds, 30)
        XCTAssertEqual(timerDetails.lastBreakMinutes, 2)
        XCTAssertEqual(timerDetails.lastBreakSeconds, 45)
        XCTAssertNil(timerDetails.edgeSize)
    }
    
    func testHasLastBreakWithMinutesOnly() {
        let timerDetails = TimerSetupDetails(lastBreakMinutes: 2)
        XCTAssertFalse(timerDetails.hasLastBreak)
    }
    
    func testHasLastBreakWithSecondsOnly() {
        let timerDetails = TimerSetupDetails(lastBreakSeconds: 25)
        XCTAssertFalse(timerDetails.hasLastBreak)
    }
    
    func testHasLastBreak() {
        let timerDetails = TimerSetupDetails(lastBreakMinutes: 2, lastBreakSeconds: 25)
        XCTAssertTrue(timerDetails.hasLastBreak)
    }
    
    func testValuesCorrectWithEdgeSize() {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30,
            lastBreakMinutes: 2,
            lastBreakSeconds: 45,
            edgeSize: 12)
        XCTAssertEqual(timerDetails.sets, 2)
        XCTAssertEqual(timerDetails.reps, 3)
        XCTAssertEqual(timerDetails.workSeconds, 7)
        XCTAssertEqual(timerDetails.restSeconds, 3)
        XCTAssertEqual(timerDetails.breakMinutes, 1)
        XCTAssertEqual(timerDetails.breakSeconds, 30)
        XCTAssertEqual(timerDetails.lastBreakMinutes, 2)
        XCTAssertEqual(timerDetails.lastBreakSeconds, 45)
        XCTAssertEqual(timerDetails.edgeSize, 12)
    }

    func testChangingValuesIsCorrect() {
        var timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 30)
        timerDetails.sets = 3
        timerDetails.reps = 4
        timerDetails.workSeconds = 8
        timerDetails.restSeconds = 4
        timerDetails.breakMinutes = 2
        timerDetails.breakSeconds = 40
        
        XCTAssertEqual(timerDetails.sets, 3)
        XCTAssertEqual(timerDetails.reps, 4)
        XCTAssertEqual(timerDetails.workSeconds, 8)
        XCTAssertEqual(timerDetails.restSeconds, 4)
        XCTAssertEqual(timerDetails.breakMinutes, 2)
        XCTAssertEqual(timerDetails.breakSeconds, 40)
    }

}
