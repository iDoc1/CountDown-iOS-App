//
//  TimerUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 9/27/23.
//

import Foundation

/// Takes a number of minutes and seconds then returns a string representation of the given time in the format "mm:ss"
/// - Parameters:
///   - minutes: Number of minutes to display. Defaults to zero if not specified.
///   - seconds: Number of seconds to display. Does not need to be zero-padded. Defaults to zero.
/// - Returns: A String representation of the given time
func timeToString(minutes: Int = 0, seconds: Int = 0) -> String {
    let totalMinutes = seconds / 60 + minutes
    let totalSeconds = seconds % 60
    
    return totalSeconds > 9
        ? "\(totalMinutes):\(totalSeconds)"
        : "\(totalMinutes):0\(totalSeconds)"
}


/// Takes a number of seconds and returns a string in the format "1hr 36min 12sec"
/// - Parameter seconds: The number of seconds to conver to a String
/// - Returns: A formatted time String
func secondsToLongString(seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let seconds = seconds % 60
    
    // Only show hours if it is not zero
    if hours == 0 {
        return "\(minutes)min \(seconds)sec"
    } else {
        return "\(hours)hr \(minutes)min \(seconds)sec"
    }
}
