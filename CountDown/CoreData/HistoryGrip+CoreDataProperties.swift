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
    
    @NSManaged public var gripTypeName: String?
    @NSManaged public var setCount: Int16
    @NSManaged public var repCount: Int16
    @NSManaged public var workSeconds: Int16
    @NSManaged public var restSeconds: Int16
    @NSManaged public var breakMinutes: Int16
    @NSManaged public var breakSeconds: Int16
    @NSManaged public var lastBreakMinutes: Int16
    @NSManaged public var lastBreakSeconds: Int16
    @NSManaged public var edgeSize: Int16
    @NSManaged public var sequenceNum: Int16
    @NSManaged public var workoutHistory: WorkoutHistory?
    
    public var unwrappedBreakMinutes: Int {
        Int(breakMinutes)
    }
    
    public var unwrappedBreakSeconds: Int {
        Int(breakSeconds)
    }
    
    public var unwrappedLastBreakMinutes: Int {
        Int(lastBreakMinutes)
    }
    
    public var unwrappedLastBreakSeconds: Int {
        Int(lastBreakSeconds)
    }
    
    public var unwrappedEdgeSize: Int? {
        (edgeSize != 0) ? Int(edgeSize) : nil
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
        gripTypeName ?? "Unknown Grip Type"
    }

}

extension HistoryGrip : Identifiable {

}
