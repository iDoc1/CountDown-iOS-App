//
//  SleepUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 10/8/23.
//

import SwiftUI

/// Disables the idle timer that causes the device to go to sleep after a set amount of time
func disableSleepMode() {
    UIApplication.shared.isIdleTimerDisabled = true
}

/// Enables the idle timer that causes the device to go to sleep after a set amount of time
func enableSleepMode() {
    UIApplication.shared.isIdleTimerDisabled = false
}
