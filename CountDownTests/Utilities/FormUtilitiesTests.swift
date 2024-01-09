//
//  FormUtilitiesTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 1/7/24.
//

import XCTest
@testable import CountDown

final class FormUtilitiesTests: XCTestCase {

    func testSuggestedGripTypesAreCorrect() throws {
        let suggested = getSuggestedGripTypes(newGripTypeName: "cRi")
        XCTAssertEqual(suggested, ["Full Crimp", "Half Crimp", "Open Hand Crimp"])
    }
    
    func testSuggestedGripTypesIsEmpty() {
        let suggested = getSuggestedGripTypes(newGripTypeName: "CRIMPX")
        XCTAssertEqual(suggested, [])
    }
    
    func testSuggesteGripTypesWorksWithSpaces() {
        let suggested = getSuggestedGripTypes(newGripTypeName: " crim")
        XCTAssertEqual(suggested, ["Full Crimp", "Half Crimp", "Open Hand Crimp"])
    }
}
