//
//  GripsTest.swift
//  CountDownUITests
//
//  Created by Ian Docherty on 12/10/23.
//

import XCTest

final class GripsTest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launchArguments += ["UI-Testing-Preload-Workout"]
        app.launch()
        continueAfterFailure = false
    }
    
    /// Adds a new grip to the existing "Test Workout" workout. Checks that new grip is added and "Start Workout" button is enabled
    func testAddNewGrip() throws {
        let createdWorkoutTitle = app.staticTexts["Test Workout"]
        XCTAssert(createdWorkoutTitle.waitForExistence(timeout: 0.5))
        
        createdWorkoutTitle.tap()
        let gripsLink = app.otherElements.buttons["addGripsNavLink"]
        XCTAssert(gripsLink.exists)
        
        // Navigate to workout grips screen
        gripsLink.tap()
        let noGripsMessage = app.staticTexts["No grips added yet"]
        XCTAssert(noGripsMessage.waitForExistence(timeout: 0.5))
        
        let addGripButton = app.buttons["Add Grip"]
        addGripButton.tap()
        
        let addGripTitle = app.staticTexts["Add Grip"]
        XCTAssert(addGripTitle.waitForExistence(timeout: 0.5))
        
        let gripTypesLink = app.otherElements.buttons["gripTypesNavLink"]
        XCTAssert(gripTypesLink.exists)
        
        // Add and select a test grip type
        gripTypesLink.tap()
        let gripTypeField = app.textFields["New Grip Type"]
        gripTypeField.tap()
        gripTypeField.typeText("Test Grip Type")
        let addGripTypeButton = app.buttons["Add Grip Type"]
        addGripTypeButton.tap()
        
        let createdGripType = app.buttons["Test Grip Type"]
        XCTAssert(createdGripType.waitForExistence(timeout: 0.5))
        createdGripType.tap()
        let checkIcon = app.otherElements.images["selectedGripType"]
        XCTAssert(checkIcon.waitForExistence(timeout: 0.5))
        
        // Navigate back to grips screen and check that new grip was created
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssert(addGripTitle.waitForExistence(timeout: 0.5))
        
        let confirmAddButton = app.buttons["Confirm Add Grip"]
        confirmAddButton.tap()
        
        let createdGripTitle  = app.staticTexts["Test Grip Type"]
        XCTAssert(createdGripTitle.waitForExistence(timeout: 0.5))
        
        // Navigate back and check that start workout button is enable
        app.navigationBars.buttons.element(boundBy: 0).tap()
        let startWorkoutLink = app.otherElements.buttons["startWorkoutLink"]
        XCTAssert(startWorkoutLink.waitForExistence(timeout: 0.5))
        XCTAssertTrue(startWorkoutLink.isEnabled)
    }
    
    /// Checks that the correct error message appears if a grip type is not specified
    func testAddNewGripWithoutGripType() throws {
        let createdWorkoutTitle = app.staticTexts["Test Workout"]
        XCTAssert(createdWorkoutTitle.waitForExistence(timeout: 0.5))
        
        createdWorkoutTitle.tap()
        let gripsLink = app.otherElements.buttons["addGripsNavLink"]
        XCTAssert(gripsLink.exists)
        
        // Navigate to workout grips screen
        gripsLink.tap()
        let noGripsMessage = app.staticTexts["No grips added yet"]
        XCTAssert(noGripsMessage.waitForExistence(timeout: 0.5))
        
        let addGripButton = app.buttons["Add Grip"]
        addGripButton.tap()
        
        let addGripTitle = app.staticTexts["Add Grip"]
        XCTAssert(addGripTitle.waitForExistence(timeout: 0.5))
        
        let confirmAddButton = app.buttons["Confirm Add Grip"]
        confirmAddButton.tap()
        
        let errorMessage  = app.staticTexts["- Grip Type must be specified"]
        XCTAssert(errorMessage.waitForExistence(timeout: 0.5))
    }
    
    /// Checks that the "Start Workout" button is disabled if there are not grips
    func testCannotStartWorkoutWithNoGrips() throws {
        let createdWorkoutTitle = app.staticTexts["Test Workout"]
        XCTAssert(createdWorkoutTitle.waitForExistence(timeout: 0.5))
        
        createdWorkoutTitle.tap()
        let gripsLink = app.otherElements.buttons["addGripsNavLink"]
        XCTAssert(gripsLink.exists)
        
        let startWorkoutLink = app.otherElements.buttons["startWorkoutLink"]
        XCTAssertFalse(startWorkoutLink.isEnabled)
    }
}
