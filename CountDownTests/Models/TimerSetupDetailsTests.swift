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
