//
//  CountDownUITests.swift
//  CountDownUITests
//
//  Created by Ian Docherty on 12/10/23.
//

import XCTest

final class WorkoutTests: XCTestCase {

    /// A new workout is created and added
    func testNewWorkoutAddedCorrectly() throws {
        let app = XCUIApplication()
        app.launchArguments += ["UI-Testing-Empty"]
        app.launch()
        continueAfterFailure = false
        
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
    
    /// Error messages appear if workout name and description are not specified
    func testNewWorkoutRequiresNameAndDescription() throws {
        let app = XCUIApplication()
        app.launchArguments += ["UI-Testing-Empty"]
        app.launch()
        continueAfterFailure = false
        
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
    
    /// An alert message shows when workout deletion is attempted. Deletion works as intended with alert dialog.
    func testWorkoutAlertShowsOnDeletion() throws {
        let app = XCUIApplication()
        app.launchArguments += ["UI-Testing-Preload-Workout"]
        app.launch()
        continueAfterFailure = false
        
        let workoutListItem = app.staticTexts["Test Workout"]
        workoutListItem.swipeLeft()
        let deleteButton = app.buttons["Delete"]
        XCTAssert(deleteButton.waitForExistence(timeout: 0.5))
        
        deleteButton.tap()
        let alertMessage = app.staticTexts["Delete Workout"]
        XCTAssert(alertMessage.waitForExistence(timeout: 0.5))
        
        // Cancelling does not delete workout
        let cancelDeleteButton = app.buttons["Cancel"]
        cancelDeleteButton.tap()
        XCTAssert(workoutListItem.exists)
        
        // Deleting workout succeeds
        workoutListItem.swipeLeft()
        XCTAssert(deleteButton.waitForExistence(timeout: 0.5))
        deleteButton.tap()
        XCTAssert(alertMessage.waitForExistence(timeout: 0.5))
        let confirmDeleteButton = app.buttons["Delete"]
        confirmDeleteButton.tap()
        
        let emptyWorkoutsText = app.staticTexts["No workouts added yet"]
        XCTAssert(emptyWorkoutsText.waitForExistence(timeout: 0.5))
    }
}
