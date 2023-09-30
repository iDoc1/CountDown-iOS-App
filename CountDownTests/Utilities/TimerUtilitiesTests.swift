//
//  TimerUtilitiesTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/27/23.
//

import XCTest
@testable import CountDown

final class TimerUtilitiesTests: XCTestCase {

    func testTimeToStringSingleDigitSeconds()  {
        let time = timeToString(seconds: 7)
        XCTAssertEqual(time, "0:07")
    }
    
    func testTimeToStringDoubleDigitSeconds()  {
        let time = timeToString(seconds: 12)
        XCTAssertEqual(time, "0:12")
    }
    
    func testTimeToStringSingleDigitMinutes()  {
        let time = timeToString(minutes: 1)
        XCTAssertEqual(time, "1:00")
    }
    
    func testTimeToStringDoubleDigitMinutes()  {
        let time = timeToString(minutes: 45)
        XCTAssertEqual(time, "45:00")
    }
    
    func testTimeToStringMinutesAndSingleDigitSeconds()  {
        let time = timeToString(minutes: 1, seconds: 7)
        XCTAssertEqual(time, "1:07")
    }
    
    func testTimeToStringMinutesAndDoubleDigitSeconds()  {
        let time = timeToString(minutes: 1, seconds: 12)
        XCTAssertEqual(time, "1:12")
    }
    
    func testTimeToStringSecondsAbove60()  {
        let time = timeToString(minutes: 0, seconds: 67)
        XCTAssertEqual(time, "1:07")
    }
    
    func testTimeToStringSecondsEqual60()  {
        let time = timeToString(minutes: 0, seconds: 60)
        XCTAssertEqual(time, "1:00")
    }
    
    func testTimeToStringSecondsAbove60WithMinutes()  {
        let time = timeToString(minutes: 1, seconds: 67)
        XCTAssertEqual(time, "2:07")
    }
}
