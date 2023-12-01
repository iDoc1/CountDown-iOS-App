//
//  WorkoutHistory+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 11/30/23.
//
//

import Foundation
import CoreData


extension WorkoutHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutHistory> {
        return NSFetchRequest<WorkoutHistory>(entityName: "WorkoutHistory")
    }

    @NSManaged public var workoutDate: Date?
    @NSManaged public var notes: String?
    @NSManaged public var totalSeconds: Int16
    @NSManaged public var workout: Workout?
    @NSManaged public var historyGrip: NSSet?
    
    public var unwrappedWorkouDate: Date {
        workoutDate ?? Date()
    }

}

// MARK: Generated accessors for historyGrip
extension WorkoutHistory {

    @objc(addHistoryGripObject:)
    @NSManaged public func addToHistoryGrip(_ value: HistoryGrip)

    @objc(removeHistoryGripObject:)
    @NSManaged public func removeFromHistoryGrip(_ value: HistoryGrip)

    @objc(addHistoryGrip:)
    @NSManaged public func addToHistoryGrip(_ values: NSSet)

    @objc(removeHistoryGrip:)
    @NSManaged public func removeFromHistoryGrip(_ values: NSSet)

}

extension WorkoutHistory : Identifiable {

}
