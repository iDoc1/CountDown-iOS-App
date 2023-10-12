//
//  TimerVibrator.swift
//  CountDown
//
//  Created by Ian Docherty on 10/11/23.
//

import Foundation
import AudioToolbox

/// Provides functions to vibrate the device at a particular time left in the countdown
class TimerVibrator {
    
    /// Vibrates the device at the 3, 2, 1, and zero second marks. Any other second will not trigger a sound to be played.
    /// - Parameter newSecondsLeft: The current second left in the timer for which to play the vibrate for
    func vibrateAt(newSecondsLeft: Int) {
        switch newSecondsLeft {
        case 3, 2, 1, 0: vibrate()
        default: return
        }
    }
    
    /// Vibrates the device using the standard system vibration
    func vibrate() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
}
