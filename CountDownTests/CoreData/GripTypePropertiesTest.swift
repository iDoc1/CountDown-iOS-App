//
//  GripTypePropertiesTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 11/26/23.
//

import XCTest
import CoreData
@testable import CountDown

final class GripTypePropertiesTest: XCTestCase {
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }
    
    func testUnwrappedPropertiesAreCorrect() throws {
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        try context.save()
        
        XCTAssertEqual(gripType.unwrappedName, "Half Crimp")
    }
    
    func testNilPropertiesAreCorrect() throws {
        let gripType = GripType(context: context)
        
        XCTAssertEqual(gripType.unwrappedName, "Unknown Grip Type")
    }
}
