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
    
    @NSManaged public var secondsBetweenHands: Int16
    @NSManaged public var startHand: String?
    @NSManaged public var isLeftRightEnabled: Bool
    @NSManaged public var createdDate: Date?
    @NSManaged public var descriptionText: String?
    @NSManaged public var foreignID: UUID?
    @NSManaged public var hangboardName: String?
    @NSManaged public var name: String?
    @NSManaged public var grip: NSSet?
    @NSManaged public var history: NSSet?
    @NSManaged public var workoutType: WorkoutType?
    
    public var unwrappedSecondsBetweenHands: Int {
        Int(secondsBetweenHands)
    }
    
    public var unwrappedStartHand: String {
        startHand ?? "Left"
    }
    
    public var unwrappedIsLeftRightEnabled: Bool {
        isLeftRightEnabled
    }
    
    public var unwrappedCreatedDate: Date? {
        createdDate ?? nil
    }
    
    public var unwrappedDescriptionText: String {
        descriptionText ?? "Unknown Description"
    }
    
    public var unwrappedHangboardName: String {
        hangboardName ?? ""
    }
    
    public var unwrappedName: String {
        name ?? "Unknown Workout"
    }
    
    public var unwrappedWorkoutTypeName: String {
        workoutType?.unwrappedName ?? "Unknown Type"
    }
    
    /// An array of all grips related to this workout sorted by grip sequence number
    public var gripArray: [Grip] {
        let set = grip as? Set<Grip> ?? []
        return set.sorted {
            $0.sequenceNum < $1.sequenceNum
        }
    }
    
    /// The max sequence number value for all grips in this workout
    public var maxSeqNum: Int {
        var maxNum = 0
        for grip in gripArray {
            maxNum = max(maxNum, grip.unwrappedSequenceNum)
        }
        
        return maxNum
    }
    
    /// The last date this workout was completed
    public var lastUsedDate: Date? {
        let set = history as? Set<WorkoutHistory> ?? []
        let sortedHistory = set.sorted {
            $0.unwrappedWorkoutDate > $1.unwrappedWorkoutDate
        }
        
        return sortedHistory.first?.workoutDate
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
