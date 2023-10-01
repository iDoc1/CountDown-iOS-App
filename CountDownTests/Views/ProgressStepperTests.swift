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
            color: Theme.lightBlue.mainColor)
        let title = try view.inspect().hStack().text(0).string()

        // Ensure the correct title and indices are displayed
        XCTAssertEqual(title, "Sets")
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "1"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "2"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "3"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "4"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "5"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "6"))
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "7"))
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "0"), "Does not contain '0'")
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "8"), "Does not contain '8'")
    }

    func testStepperShowsBox12() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 12,
            currIndex: 3,
            color: Theme.lightBlue.mainColor)
        
        XCTAssertNoThrow(try view.inspect().hStack().find(text: "12"))
    }
    
    func testStepperShowsDoesNotShowBox13() throws {
        let view = ProgressStepper(
            title: "Sets",
            length: 13,
            currIndex: 3,
            color: Theme.lightBlue.mainColor)
        
        XCTAssertThrowsError(try view.inspect().hStack().find(text: "13"))
    }
}
