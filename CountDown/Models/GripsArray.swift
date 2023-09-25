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
        /// Optional break that occurs between grips that takes precedence over the standard break duration. There are some
        /// where a user may want the break duration between grips to be different that the break duration between sets. This property
        /// is used for that scenario.
        var preGripBreak: DurationStatus?
    }
    
    /// Stores a number of seconds with a duration type. For example, a 10-second work duration could be represented by this struct.
    struct DurationStatus: CustomStringConvertible {
        let seconds: Int
        let durationType: DurationType
        let currSet: Int
        let currRep: Int
        
        /// Returns a string representation of this struct. Example: "WORK for 3 sec".
        var description: String {
            "\(durationType.rawValue) for \(seconds) sec"
        }
    }
    
    init(timerDetails: TimerSetupDetails) {
        buildArrayFromTimerSetup(timerDetails: timerDetails)
    }
    
    /// Enables use of the [index] operator on this struct
    subscript (index: Int) -> WorkoutGrip {
        grips[index]
    }
    
    /// The number of grips in this struct
    var count: Int {
        grips.count
    }
    
    /// Builds durations array for this struct using the given TimerSetupDetails struct. Only includes one WorkoutGrip because the
    /// TimerSetupDetails only provides info for a single grip.
    /// - Parameter timerSetupDetails: The quantity of sets and reps, and the work, rest, and break durations
    private mutating func buildArrayFromTimerSetup(timerDetails: TimerSetupDetails) {
        let currGrip = 0
        var currSet = 0
        var currRep = 0
        
        // Add a prepare duration as the first duration
        grips.append(WorkoutGrip(name: nil))
        addDuration(type: .prepareType)

        // Add sets and reps to the current grip
        while currSet < timerDetails.sets {

//            currRep = 0
            while currRep < timerDetails.reps {
                addDuration(type: .workType)
                currRep += 1
                
                while currRep < timerDetails.reps {
                    addDuration(type: .restType)
                    addDuration(type: .workType)
                    currRep += 1
                }
                
                
            }
            currSet += 1
            
            // Do not add a break duration after the last set
            if currSet < timerDetails.sets {
                currRep = 0
                addDuration(type: .breakType)
            }
        }

        /// Appends the DurationStatus with the specified DurationType to the grips array using the current state of currGrip, currSet,
        /// and currRep
        func addDuration(type: DurationType) {
            switch type {
            case .workType:
                let workDuration = DurationStatus(
                    seconds: timerDetails.workSeconds,
                    durationType: .workType,
                    currSet: currSet,
                    currRep: currRep)
                grips[currGrip].durations.append(workDuration)
            case .restType:
                let restDuration = DurationStatus(
                    seconds: timerDetails.restSeconds,
                    durationType: .restType,
                    currSet: currSet,
                    currRep: currRep)
                grips[currGrip].durations.append(restDuration)
            case .breakType:
                let breakSeconds = (timerDetails.breakMinutes * 60) + timerDetails.breakSeconds
                let breakDuration = DurationStatus(
                    seconds: breakSeconds,
                    durationType: .breakType,
                    currSet: currSet,
                    currRep: currRep)
                grips[currGrip].durations.append(breakDuration)
            case .prepareType:
                let prepareDuration = DurationStatus(
                    seconds: 15,
                    durationType: .prepareType,
                    currSet: currSet,
                    currRep: currRep)
                grips[currGrip].durations.append(prepareDuration)
            }
        }
    }
    
}
