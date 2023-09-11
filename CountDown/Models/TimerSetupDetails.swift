//
//  TimerSetupDetails.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import Foundation

/// Stores timer quantities for the Timer Setup view. These quantities are to be used by the countdown timer.
struct TimerSetupDetails {
    var sets: Int
    var reps: Int
    var workSeconds: Int
    var restSeconds: Int
    var breakMinutes: Int
    var breakSeconds: Int
    
    init(
        sets: Int = 1,
        reps: Int = 1,
        workSeconds: Int = 7,
        restSeconds: Int = 3,
        breakMinutes: Int = 1,
        breakSeconds: Int = 0) {
            self.sets = sets
            self.reps = reps
            self.workSeconds = workSeconds
            self.restSeconds = restSeconds
            self.breakMinutes = breakMinutes
            self.breakSeconds = breakSeconds
        }
}
