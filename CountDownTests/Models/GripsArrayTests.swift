//
//  GripsArrayTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 9/23/23.
//

import XCTest
@testable import CountDown

final class GripsArrayTests: XCTestCase {
    
    func testDurationStatusDescription() {
        let durationStatus = GripsArray.DurationStatus(
            seconds: 7,
            durationType: .workType,
            currSet: 1,
            currRep: 1)
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
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
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
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
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
        XCTAssertEqual(gripsArray[0].durations.count, 1)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)
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
        XCTAssertEqual(gripsArray[0].durations.count, 2)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
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
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
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
        XCTAssertEqual(gripsArray[0].durations.count, 4)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 0)
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
        XCTAssertEqual(gripsArray[0].durations.count, 8)
        XCTAssertEqual(gripsArray[0].workSeconds, 7)
        XCTAssertEqual(gripsArray[0].restSeconds, 3)
        XCTAssertEqual(gripsArray[0].breakMinutes, 1)
        XCTAssertEqual(gripsArray[0].breakSeconds, 30)
        
        XCTAssertEqual(gripsArray[0].durations[0].description, "PREPARE for 15 sec")
        XCTAssertEqual(gripsArray[0].durations[0].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[0].currRep, 0)

        XCTAssertEqual(gripsArray[0].durations[1].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[1].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[1].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[2].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[2].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[2].currRep, 1)
        
        XCTAssertEqual(gripsArray[0].durations[3].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[3].currSet, 0)
        XCTAssertEqual(gripsArray[0].durations[3].currRep, 1)
        
        XCTAssertEqual(gripsArray[0].durations[4].description, "BREAK for 90 sec")
        XCTAssertEqual(gripsArray[0].durations[4].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[4].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[5].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[5].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[5].currRep, 0)
        
        XCTAssertEqual(gripsArray[0].durations[6].description, "REST for 3 sec")
        XCTAssertEqual(gripsArray[0].durations[6].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[6].currRep, 1)
        
        XCTAssertEqual(gripsArray[0].durations[7].description, "WORK for 7 sec")
        XCTAssertEqual(gripsArray[0].durations[7].currSet, 1)
        XCTAssertEqual(gripsArray[0].durations[7].currRep, 1)
    }
}
