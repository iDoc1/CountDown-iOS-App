//
//  Workout+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 10/23/23.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var descriptionText: String?
    @NSManaged public var foreignID: UUID?
    @NSManaged public var hangboardName: String?
    @NSManaged public var lastUsedDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var grip: NSSet?
    @NSManaged public var workoutType: WorkoutType?
    
    public var unwrappedCreatedDate: Date {
        createdDate ?? Date()
    }
    
    public var unwrappedDescriptionText: String {
        descriptionText ?? "Unknown Description"
    }
    
    public var unwrappedHangboardName: String {
        hangboardName ?? "None Specified"
    }
    
    public var unwrappedLastUsedDate: Date {
        lastUsedDate ?? Date()
    }
    
    public var unwrappedName: String {
        name ?? "Unknown Workout"
    }
    
    public var unwrappedWorkoutTypeName: String {
        workoutType?.unwrappedName ?? "Unkown Type"
    }
}

// MARK: Generated accessors for grip
extension Workout {

    @objc(addGripObject:)
    @NSManaged public func addToGrip(_ value: Grip)

    @objc(removeGripObject:)
    @NSManaged public func removeFromGrip(_ value: Grip)

    @objc(addGrip:)
    @NSManaged public func addToGrip(_ values: NSSet)

    @objc(removeGrip:)
    @NSManaged public func removeFromGrip(_ values: NSSet)

}

extension Workout : Identifiable {

}
