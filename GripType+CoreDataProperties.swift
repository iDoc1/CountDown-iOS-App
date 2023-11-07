//
//  GripType+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 10/23/23.
//
//

import Foundation
import CoreData


extension GripType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GripType> {
        return NSFetchRequest<GripType>(entityName: "GripType")
    }

    @NSManaged public var name: String?
    @NSManaged public var grip: NSSet?
    
    public var unwrappedName: String {
        name ?? "Grip Type Deleted"
    }
}

// MARK: Generated accessors for grip
extension GripType {

    @objc(addGripObject:)
    @NSManaged public func addToGrip(_ value: Grip)

    @objc(removeGripObject:)
    @NSManaged public func removeFromGrip(_ value: Grip)

    @objc(addGrip:)
    @NSManaged public func addToGrip(_ values: NSSet)

    @objc(removeGrip:)
    @NSManaged public func removeFromGrip(_ values: NSSet)

}

extension GripType : Identifiable {

}
