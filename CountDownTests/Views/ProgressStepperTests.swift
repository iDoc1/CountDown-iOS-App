//
//  ProgressStepperUITest.swift
//  CountDownUITests
//
//  Created by Ian Docherty on 9/30/23.
//

import XCTest
import ViewInspector
@testable import CountDown

final class ProgressStepperTest: XCTestCase {
    
    func testStepperContainsCorrectText() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 7,
            currIndex: 3,
            color: Theme.lightBlue.mainColor,
            isDecremented: false)

        // Ensure the correct title and indices are displayed
        XCTAssertNoThrow(try view.inspect().find(text: "Sets"))
        XCTAssertNoThrow(try view.inspect().find(text: "1"))
        XCTAssertNoThrow(try view.inspect().find(text: "2"))
        XCTAssertNoThrow(try view.inspect().find(text: "3"))
        XCTAssertNoThrow(try view.inspect().find(text: "4"))
        XCTAssertNoThrow(try view.inspect().find(text: "5"))
        XCTAssertNoThrow(try view.inspect().find(text: "6"))
        XCTAssertNoThrow(try view.inspect().find(text: "7"))
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "0"))
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "8"))
    }

    func testStepperShowsBox12() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 12,
            currIndex: 3,
            color: Theme.lightBlue.mainColor,
            isDecremented: false)
        
        XCTAssertNoThrow(try view.inspect().find(text: "12"))
    }
    
    func testStepperShowsDoesNotShowBox13() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 13,
            currIndex: 3,
            color: Theme.lightBlue.mainColor,
            isDecremented: false)
        
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "13"))
    }
    
    func testStepperShowsMinusSign() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 7,
            currIndex: 3,
            color: Theme.lightBlue.mainColor,
            isDecremented: true)
        
        XCTAssertNoThrow(try view.inspect().find(text: "-"))
    }
}
