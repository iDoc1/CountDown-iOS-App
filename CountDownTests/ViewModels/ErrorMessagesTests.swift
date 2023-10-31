//
//  ErrorMessagesTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 10/26/23.
//

import XCTest
@testable import CountDown

final class ErrorMessagesTests: XCTestCase {
    func testErrorMessagesCorrectlyAddsOneErrorMessage() {
        let errorMessages = ErrorMessages()
        errorMessages.addError("Error message 1")
        XCTAssertEqual(errorMessages.errors.count, 1)
        XCTAssertEqual(errorMessages.errors[0], "Error message 1")
    }

    func testErrorMessagesCorrectlyAddsTwoErrorMessages() {
        let errorMessages = ErrorMessages()
        errorMessages.addError("Error message 1")
        errorMessages.addError("Error message 2")
        XCTAssertEqual(errorMessages.errors.count, 2)
        XCTAssertEqual(errorMessages.errors[0], "Error message 1")
        XCTAssertEqual(errorMessages.errors[1], "Error message 2")
    }
    
    func testErrorMessagesClear() {
        let errorMessages = ErrorMessages()
        errorMessages.addError("Error message 1")
        XCTAssertEqual(errorMessages.errors.count, 1)
        
        errorMessages.clearErrors()
        XCTAssertEqual(errorMessages.errors.count, 0)
    }
}
