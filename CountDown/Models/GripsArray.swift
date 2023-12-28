//
//  DurationArray.swift
//  CountDown
//
//  Created by Ian Docherty on 9/17/23.
//

import Foundation
import SwiftUI

/// Contains a collection of grips, each containing a collection of elements representing the sets and reps within a grip.
struct GripsArray {
    var grips: [WorkoutGrip] = []
    
    /// The types of durations a timer can have. Each case corresponds to a string that may be displayed in the countdown timer
    enum DurationType: String {
        case workType = "WORK"
        case restType = "REST"
        case breakType = "BREAK"
        case prepareType = "PREPARE"
        
        /// The color corresponding to this DurationType
        var timerColor: Color {
            switch self {
            case .workType:
                return Theme.lightGreen.mainColor
            case .restType:
                return Theme.mediumYellow.mainColor
            case .breakType:
                return Theme.brightRed.mainColor
            case .prepareType:
                return Theme.lightBlue.mainColor
            }
        }
    }
    
    /// A particular grip that contains a collection of workout DurationStatus structs
    struct WorkoutGrip {
        let name: String?
        var durations: [DurationStatus] = []
        var totalSets: Int
        var totalReps: Int
        var workSeconds: Int
        var restSeconds: Int
        var decrementSets: Bool
        var breakMinutes: Int
        var breakSeconds: Int
        var lastBreakMinutes: Int?
        var lastBreakSeconds: Int?
        var edgeSize: Int?
        var hasCustomDurations: Bool
        var customWorkSeconds: [Int]
        var customRestSeconds: [Int]
        /// Optional break that occurs between grips that takes precedence over the standard break duration. There are some
        /// where a user may want the break duration between grips to be different that the break duration between sets. This property
        /// is used for that scenario.
        var preGripBreak: DurationStatus?
        
        /// String representation of the workSeconds
        var workTime: String {
            timeToString(seconds: workSeconds)
        }
        
        /// String representation of the restSeconds
        var restTime: String {
            timeToString(seconds: restSeconds)
        }
        
        /// String representation of the workSeconds
        var breakTime: String {
            timeToString(minutes: breakMinutes, seconds: breakSeconds)
        }
    }
    
    /// Stores a number of seconds with a duration type. For example, a 10-second work duration could be represented by this struct.
    struct DurationStatus: CustomStringConvertible {
        let seconds: Int
        let durationType: DurationType
        let currSet: Int
        let currRep: Int
        /// The time at which this duration starts within the scope of the entire workout
        let startSeconds: Int
        
        /// Returns a string representation of this struct. Example: "WORK for 3 sec".
        var description: String {
            "\(durationType.rawValue) for \(seconds) sec"
        }
    }
    
    init(grip: GripViewModel) {
        buildArrayFromGripViewModel(grip: grip)
    }
    
    init(grips: [Grip]) {
        buildArrayFromGrips(grips: grips)
    }
    
    /// Enables use of the [index] operator on this struct
    subscript (index: Int) -> WorkoutGrip {
        grips[index]
    }
    
    /// The number of grips in this struct
    var count: Int {
        grips.count
    }
    
    /// Returns the total number of seconds for all grips and durations in this GripsArray
    var totalSeconds: Int {
        return secondsElapsed
    }
    
    /// Returns the last grip in the array. If that grip does not exists, returns a WorkoutGrip with all zeroes.
    var last: WorkoutGrip {
        return grips.last ?? WorkoutGrip(
            name: nil,
            totalSets: 0,
            totalReps: 0,
            workSeconds: 0,
            restSeconds: 0,
            decrementSets: false,
            breakMinutes: 0,
            breakSeconds: 0,
            hasCustomDurations: false,
            customWorkSeconds: [],
            customRestSeconds: [])
    }
    
    private var secondsElapsed = 0
    
    /// Builds durations array for this struct using the given GripViewModel struct. Only includes one WorkoutGrip because the Timer
    /// Setup screen only needs a single grip to create a timer.
    /// - Parameter grip: The GripViewModel object
    private mutating func buildArrayFromGripViewModel(grip: GripViewModel) {
        addGrip(grip: grip, gripNum: 0, isLastGrip: true)
    }
    
    /// Builds durations array for this struct using the given array of Grip objects
    /// - Parameter workout: The Core Data Workout object
    private mutating func buildArrayFromGrips(grips: [Grip]) {
        for index in 0..<grips.count {
            let currGrip = grips[index]
            
            var prevGrip: Grip? = nil
            if index > 0 {
                prevGrip = grips[index - 1]
            }
            
            var grip = GripViewModel()
            grip.setCount = currGrip.unwrappedSetCount
            grip.repCount = currGrip.unwrappedRepCount
            grip.workSeconds = currGrip.unwrappedWorkSeconds
            grip.restSeconds = currGrip.unwrappedRestSeconds
            grip.breakMinutes = currGrip.unwrappedBreakMinutes
            grip.breakSeconds = currGrip.unwrappedBreakSeconds
            /**
             Last break is always taken from the previous grip because the last break must be inserted as the first duration in
             each grip. For example, if the previous grip has a last break of 1:30 then that will be the first duration in the current
             grip. If the current grip is the first grip in the workout then no last break is added.
             */
            grip.lastBreakMinutes = prevGrip?.unwrappedLastBreakMinutes ?? 0
            grip.lastBreakSeconds = prevGrip?.unwrappedLastBreakSeconds ?? 0
            
            grip.hasCustomDurations = currGrip.unwrappedHasCustomDurations
            grip.customWorkSeconds = currGrip.unwrappedCustomWork
            grip.customRestSeconds = currGrip.unwrappedCustomRest
            grip.edgeSize = currGrip.unwrappedEdgeSize
            grip.decrementSets = currGrip.unwrappedDecrementSets

            // Include a Prepare duration for the first grip only
            addGrip(
                grip: grip,
                gripNum: index,
                gripName: currGrip.unwrappedGripTypeName,
                isLastGrip: index == grips.count - 1)
        }
    }
    
    /// Adds the a grip with the given name and timer details to the grips array
    /// - Parameters:
    ///   - grip: The GripViewModel object containing the sets and reps, and workout durations
    ///   - gripNum: The zero-indexed number of this grip in the workout
    ///   - gripName: Optional grip name. If not specified, defaults to nil.
    ///   - isLastGrip: Specifies if this grip is the last one in the workout. Defaults to false.
    private mutating func addGrip(
        grip: GripViewModel,
        gripNum: Int,
        gripName: String? = nil,
        isLastGrip: Bool = false
    ) {
        let currGrip = gripNum
        var currSet = 0
        var currRep = 0
        
        grips.append(WorkoutGrip(
            name: gripName,
            totalSets: grip.setCount,
            totalReps: grip.repCount,
            workSeconds: grip.workSeconds,
            restSeconds: grip.restSeconds,
            decrementSets: grip.decrementSets,
            breakMinutes: grip.breakMinutes,
            breakSeconds: grip.breakSeconds,
            lastBreakMinutes: grip.lastBreakMinutes,
            lastBreakSeconds: grip.lastBreakSeconds,
            edgeSize: grip.edgeSize,
            hasCustomDurations: grip.hasCustomDurations,
            customWorkSeconds: grip.customWorkSeconds,
            customRestSeconds: grip.customRestSeconds))
        
        // Add a prepare duration only for the first grip
        if gripNum == 0 {
            addDuration(type: .prepareType)
            
        // Add a last break duration prior to the first set for all grips except the first one
        } else {
            addDuration(type: .breakType)
        }

        // Add sets and reps to the current grip
        while currSet < grip.setCount {

            if currRep < grip.repCount {
                addDuration(type: .workType)
                currRep += 1
            }
            
            var maxReps = grip.repCount
            
            // Decrease reps by one if current set is odd and decrement sets is true
            if currSet % 2 == 1 && grip.decrementSets {
                maxReps -= 1
            }
                
            while currRep < maxReps {
                addDuration(type: .restType)
                addDuration(type: .workType)
                currRep += 1
            }
            
            currSet += 1

            // Do not include a break after the last set
            if currSet < grip.setCount {
                currRep = 0
                addDuration(type: .breakType)
            }
        }
        
        /// Appends the DurationStatus with the specified DurationType to the grips array using the current state of currGrip, currSet,
        /// and currRep
        func addDuration(type: DurationType) {
            switch type {
            case .workType:
                let workSeconds: Int
                
                // Use custom work seconds if custom durations is turned on
                if grip.hasCustomDurations {
                    workSeconds = grip.customWorkSeconds[currRep]
                } else {
                    workSeconds = grip.workSeconds
                }
                
                let workDuration = DurationStatus(
                    seconds: workSeconds,
                    durationType: .workType,
                    currSet: currSet,
                    currRep: currRep,
                    startSeconds: secondsElapsed)
                secondsElapsed += workDuration.seconds
                grips[currGrip].durations.append(workDuration)
            case .restType:
                let restSeconds: Int
                
                // Use custom rest seconds if custom durations is turned on
                if grip.hasCustomDurations {
                    // Subtract one because rep has already incremented after work duration
                    restSeconds = grip.customRestSeconds[currRep - 1]
                } else {
                    restSeconds = grip.restSeconds
                }
                
                let restDuration = DurationStatus(
                    seconds: restSeconds,
                    durationType: .restType,
                    currSet: currSet,
                    currRep: currRep,
                    startSeconds: secondsElapsed)
                secondsElapsed += restDuration.seconds
                grips[currGrip].durations.append(restDuration)
            case .breakType:
                // Do not include a break if it is the last set of the last grip
                if isLastGrip && currSet == grip.setCount {
                    return
                }

                let breakSeconds: Int
                
                // Use last break if at the beginning of a new grip. Otherwise, use normal break.
                if gripNum > 0 && currSet == 0 {
                    breakSeconds = (grip.lastBreakMinutes * 60) + grip.lastBreakSeconds
                } else {
                    breakSeconds = (grip.breakMinutes * 60) + grip.breakSeconds
                }
                
                let breakDuration = DurationStatus(
                    seconds: breakSeconds,
                    durationType: .breakType,
                    currSet: currSet,
                    currRep: currRep,
                    startSeconds: secondsElapsed)
                secondsElapsed += breakSeconds
                grips[currGrip].durations.append(breakDuration)
            case .prepareType:
                let prepareDuration = DurationStatus(
                    seconds: 15,
                    durationType: .prepareType,
                    currSet: currSet,
                    currRep: currRep,
                    startSeconds: secondsElapsed)
                secondsElapsed += 15
                grips[currGrip].durations.append(prepareDuration)
            }
        }
    }
    
}
