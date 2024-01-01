//
//  TimerUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 9/27/23.
//

import Foundation

/// Takes a number of minutes and seconds then returns a string representation of the given time in the format "hh:mm:ss". If the
/// number of hours is zero, then the returned format is "mm:ss".
/// - Parameters:
///   - hours: Number of hours to display. Defaults to zero if not specified.
///   - minutes: Number of minutes to display. Defaults to zero if not specified.
///   - seconds: Number of seconds to display. Does not need to be zero-padded. Defaults to zero.
/// - Returns: A String representation of the given time
func timeToString(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> String {
    let totalSeconds = seconds + minutes * 60 + hours * 3600
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    
    let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    
    if hours > 0 {
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        return "\(hours):\(minutesString):\(secondsString)"
    } else {
        return "\(minutes):\(secondsString)"
    }
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

/// Returns a string representation of the custom durations in the format "3,5,7s". If the reps exceeds 3 integers then a string in
/// the format "3...7" is displayed instead of showing the first and last integers only.
/// - Parameters:
///   - customSeconds: The custom durations array
///   - range: The number of integers within the customSeconds array to show in the string
/// - Returns: A string representation of the custom durations to show
func customDurationsString(customSeconds: [Int], range: Int) -> String {
    if range <= 0 || customSeconds.count == 0 {
        return "None"
    }

    let firstInt = String(customSeconds[0])
    
    if range <= 3 {
        var result = firstInt
        for index in 1..<range {
            result += ",\(customSeconds[index])"
        }
        
        return "\(result)s"
    }
    
    let lastInt = customSeconds[range - 1]
    return "\(firstInt)...\(lastInt)s"
}
