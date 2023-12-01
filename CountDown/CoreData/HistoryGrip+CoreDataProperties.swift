//
//  HistoryGrip+CoreDataProperties.swift
//  CountDown
//
//  Created by Ian Docherty on 11/30/23.
//
//

import Foundation
import CoreData


extension HistoryGrip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryGrip> {
        return NSFetchRequest<HistoryGrip>(entityName: "HistoryGrip")
    }

    @NSManaged public var setCount: Int16
    @NSManaged public var repCount: Int16
    @NSManaged public var workSeconds: Int16
    @NSManaged public var restSeconds: Int16
    @NSManaged public var breakMinutes: Int16
    @NSManaged public var breakSeconds: Int16
    @NSManaged public var edgeSize: Int16
    @NSManaged public var sequenceNum: Int16
    @NSManaged public var workoutHistory: WorkoutHistory?

}

extension HistoryGrip : Identifiable {

}
