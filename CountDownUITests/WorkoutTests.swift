//
//  CountDownUITests.swift
//  CountDownUITests
//
//  Created by Ian Docherty on 12/10/23.
//

import XCTest

final class WorkoutTests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launchArguments += ["UI-Testing"]
        app.launch()
        continueAfterFailure = false
    }

    func testNewWorkoutAddedCorrectly() throws {
        let addWorkoutButton = app.buttons["New Workout"]
        XCTAssert(addWorkoutButton.exists)
        
        addWorkoutButton.tap()
        let addWorkoutNavBar = app.staticTexts["Add Workout"]
        XCTAssert(addWorkoutNavBar.waitForExistence(timeout: 0.5))
        
        let workoutName = app.textFields["Name"]
        workoutName.tap()
        workoutName.typeText("Test Workout")
        
        let workoutDescription = app.textFields["Description"]
        workoutDescription.tap()
        workoutDescription.typeText("Test description")
        
        let addButton = app.buttons["Add"]
        addButton.tap()
        
        let createdWorkoutTitle = app.staticTexts["Test Workout"]
        XCTAssert(createdWorkoutTitle.waitForExistence(timeout: 0.5))
    }
    
    func testNewWorkoutRequiresNameAndDescription() throws {
        let addWorkoutButton = app.buttons["New Workout"]
        XCTAssert(addWorkoutButton.exists)
        
        addWorkoutButton.tap()
        let addWorkoutNavBar = app.staticTexts["Add Workout"]
        XCTAssert(addWorkoutNavBar.waitForExistence(timeout: 0.5))
        
        let addButton = app.buttons["Add"]
        addButton.tap()
        
        let nameError = app.staticTexts["- Name field cannot be empty"]
        let descriptionError = app.staticTexts["- Description field cannot be empty"]
        XCTAssert(nameError.exists)
        XCTAssert(descriptionError.exists)
    }
}
