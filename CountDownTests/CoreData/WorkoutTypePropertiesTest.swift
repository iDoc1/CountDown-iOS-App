//
//  WorkoutTypePropertiesTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/28/23.
//

import XCTest
import CoreData
@testable import CountDown

final class WorkoutTypePropertiesTest: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testUnwrappedPropertiesAreCorrect() throws {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "Repeaters"
        try context.save()
        
        XCTAssertEqual(workoutType.unwrappedName, "Repeaters")
    }
    
    func testNilPropertiesAreCorrect() throws {
        let workoutType = WorkoutType(context: context)
        
        XCTAssertEqual(workoutType.unwrappedName, "Unknown Workout Type")
    }
}
