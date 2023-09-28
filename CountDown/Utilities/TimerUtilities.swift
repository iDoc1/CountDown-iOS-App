//
//  TimerUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 9/27/23.
//

import Foundation

/// Takes a number of minutes and seconds then returns a string representation of the given time
/// - Parameters:
///   - minutes: Number of minutes to display. Defaults to zero if not specified.
///   - seconds: Number of seconds to display. Does not need to be zero-padded. Must be between 0 and 59. Defaults to zero.
/// - Returns: A String representation of the given time
func timeToString(minutes: Int = 0, seconds: Int = 0) -> String {
    return seconds > 9 ? "\(minutes):\(seconds)" : "\(minutes):0\(seconds)"
}
