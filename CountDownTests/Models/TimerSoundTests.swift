//
//  TimerSoundTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 10/9/23.
//

import XCTest
@testable import CountDown

final class TimerSoundTests: XCTestCase {

    func testAllSoundsCapitalizedCorrectly() {
        XCTAssertEqual(TimerSound.beep.displayName, "Beep")
        XCTAssertEqual(TimerSound.electric.displayName, "Electric")
        XCTAssertEqual(TimerSound.glass.displayName, "Glass")
        XCTAssertEqual(TimerSound.strings.displayName, "Strings")
        XCTAssertEqual(TimerSound.synth.displayName, "Synth")
    }
}
