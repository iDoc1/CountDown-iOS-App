//
//  Grip+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 10/23/23.
//
//

import Foundation
import CoreData


extension Grip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grip> {
        return NSFetchRequest<Grip>(entityName: "Grip")
    }

    @NSManaged public var breakMinutes: Int16
    @NSManaged public var breakSeconds: Int16
    @NSManaged public var edgeSize: Int16
    @NSManaged public var lastBreakMinutes: Int16
    @NSManaged public var lastBreakSeconds: Int16
    @NSManaged public var repCount: Int16
    @NSManaged public var restSeconds: Int16
    @NSManaged public var sequenceNum: Int16
    @NSManaged public var setCount: Int16
    @NSManaged public var workSeconds: Int16
    @NSManaged public var gripType: GripType?
    @NSManaged public var workout: Workout?
    
    public var unwrappedBreakMinutes: Int {
        Int(breakMinutes)
    }
    
    public var unwrappedBreakSeconds: Int {
        Int(breakSeconds)
    }
    
    public var unwrappedEdgeSize: Int? {
        (edgeSize != 0) ? Int(edgeSize) : nil
    }
    
    public var unwrappedLastBreakMinutes: Int {
        Int(lastBreakMinutes)
    }
    
    public var unwrappedLastBreakSeconds: Int {
        Int(lastBreakSeconds)
    }
    
    public var unwrappedRepCount: Int {
        Int(repCount)
    }
    
    public var unwrappedRestSeconds: Int {
        Int(restSeconds)
    }
    
    public var unwrappedSequenceNum: Int {
        Int(sequenceNum)
    }
    
    public var unwrappedSetCount: Int {
        Int(setCount)
    }
    
    public var unwrappedWorkSeconds: Int {
        Int(workSeconds)
    }
    
    public var unwrappedGripTypeName: String {
        gripType?.unwrappedName ?? "Unknown Grip Type"
    }
}

// MARK: Generated accessors for workout
extension Grip {

    @objc(addWorkoutObject:)
    @NSManaged public func addToWorkout(_ value: Workout)

    @objc(removeWorkoutObject:)
    @NSManaged public func removeFromWorkout(_ value: Workout)

    @objc(addWorkout:)
    @NSManaged public func addToWorkout(_ values: NSSet)

    @objc(removeWorkout:)
    @NSManaged public func removeFromWorkout(_ values: NSSet)

}

extension Grip : Identifiable {

}
