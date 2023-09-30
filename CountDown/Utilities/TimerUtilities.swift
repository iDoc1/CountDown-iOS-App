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
