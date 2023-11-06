//
//  WorkoutType+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 10/23/23.
//
//

import Foundation
import CoreData


extension WorkoutType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutType> {
        return NSFetchRequest<WorkoutType>(entityName: "WorkoutType")
    }

    @NSManaged public var name: String?
    @NSManaged public var workout: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown Workout Type"
    }
    
    /// An array of all workouts this workout type is related to sorted by name
    public var workoutArray: [Workout] {
        // This syntax was adapted from:
        // https://www.hackingwithswift.com/books/ios-swiftui/one-to-many-relationships-with-core-data-swiftui-and-fetchrequest
        let set = workout as? Set<Workout> ?? []
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for workout
extension WorkoutType {

    @objc(addWorkoutObject:)
    @NSManaged public func addToWorkout(_ value: Workout)

    @objc(removeWorkoutObject:)
    @NSManaged public func removeFromWorkout(_ value: Workout)

    @objc(addWorkout:)
    @NSManaged public func addToWorkout(_ values: NSSet)

    @objc(removeWorkout:)
    @NSManaged public func removeFromWorkout(_ values: NSSet)

}

extension WorkoutType : Identifiable {

}
