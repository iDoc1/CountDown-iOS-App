//
//  TimerSetupDetails.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import Foundation

/// Stores quantities and durations necessary to set up the countdown timer.
struct TimerSetupDetails {
    var sets: Int
    var reps: Int
    var workSeconds: Int
    var restSeconds: Int
    var breakMinutes: Int
    var breakSeconds: Int
    var lastBreakMinutes: Int?
    var lastBreakSeconds: Int?
    var edgeSize: Int?
    
    init(
        sets: Int = 1,
        reps: Int = 1,
        workSeconds: Int = 7,
        restSeconds: Int = 3,
        breakMinutes: Int = 1,
        breakSeconds: Int = 0,
        lastBreakMinutes: Int? = nil,
        lastBreakSeconds: Int? = nil,
        edgeSize: Int? = nil) {
            self.sets = sets
            self.reps = reps
            self.workSeconds = workSeconds
            self.restSeconds = restSeconds
            self.breakMinutes = breakMinutes
            self.breakSeconds = breakSeconds
            self.lastBreakMinutes = lastBreakMinutes
            self.lastBreakSeconds = lastBreakSeconds
            self.edgeSize = edgeSize
        }
    
    /// Indicates whether or not this timer setup contains last break durations
    var hasLastBreak: Bool {
        lastBreakMinutes != nil && lastBreakSeconds != nil
    }
}
