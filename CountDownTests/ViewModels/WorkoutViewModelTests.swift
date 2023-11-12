//
//  WorkoutViewModelTests.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/12/23.
//

import XCTest
import CoreData
@testable import CountDown

final class WorkoutViewModelTests: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testNewWorkoutCreatedCorrectly() throws {
        var workout = WorkoutViewModel(context: context)
        workout.name = "Repeaters"
        workout.description = "RCTM Advanced Protocol"
        workout.hangboardName = "Trango"
        workout.workoutType = WorkoutTypeAsString.powerEndurance
        workout.save()
        
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        let savedWorkout = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedWorkout?.name, "Repeaters")
        XCTAssertEqual(savedWorkout?.descriptionText, "RCTM Advanced Protocol")
        XCTAssertEqual(savedWorkout?.hangboardName, "Trango")
        XCTAssertEqual(savedWorkout?.workoutType?.name, "powerEndurance")
        XCTAssertEqual(savedWorkout?.createdDate!.get(.day), Date().get(.day))
    }
    
    func testWorkoutEditedCorrectly() throws {
        // Create workout
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        try context.save()
        
        var fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        var savedWorkout = try context.fetch(fetchRequest).first
        
        // Edit the created workout
        var workoutViewModel = WorkoutViewModel(workout: savedWorkout!, context: context)
        workoutViewModel.name = "Max Hangs"
        workoutViewModel.description = "Weighted max hangs"
        workoutViewModel.hangboardName = "Tension Wood"
        workoutViewModel.workoutType = WorkoutTypeAsString.strength
        workoutViewModel.save()
        
        fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        savedWorkout = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(savedWorkout?.name, "Max Hangs")
        XCTAssertEqual(savedWorkout?.descriptionText, "Weighted max hangs")
        XCTAssertEqual(savedWorkout?.hangboardName, "Tension Wood")
        XCTAssertEqual(savedWorkout?.workoutType?.name, "strength")
        XCTAssertEqual(savedWorkout?.createdDate!.get(.day), Date().get(.day))
    }
    
    func testCreatedDateNotChangedOnWorkoutEdit() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        let customCreatedDate = formatter.date(from: "10/01/2013 12:00")
        
        // Create workout
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Protocol"
        workout.createdDate = customCreatedDate
        workout.workoutType = workoutType
        try context.save()
        
        var fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        var savedWorkout = try context.fetch(fetchRequest).first
        
        // Re-save the workout from the view model
        var workoutViewModel = WorkoutViewModel(workout: savedWorkout!, context: context)
        workoutViewModel.save()
        
        fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        savedWorkout = try context.fetch(fetchRequest).first
        
        // Ensure created date did not change
        XCTAssertEqual(savedWorkout?.createdDate!.get(.day), 1)
        XCTAssertEqual(savedWorkout?.createdDate!.get(.month), 10)
        XCTAssertEqual(savedWorkout?.createdDate!.get(.year), 2013)
    }

}
