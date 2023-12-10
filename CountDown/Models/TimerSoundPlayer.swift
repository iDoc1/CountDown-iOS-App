//
//  TimerSoundPlayer.swift
//  CountDown
//
//  Created by Ian Docherty on 10/1/23.
//

import Foundation
import Starling

/// Takes a TimerSound type then instantiates a Starling instance to play and load the sounds of the given type.
/// In addition, defines a playSound function to play the sound pitch corresponding to the number of seconds left in the countdown.
/// Typically, the countdown should play the low sound at seconds 3, 2, and 1, then the high sound at second zero.
class TimerSoundPlayer {
    let lowSound: String
    let highSound: String
    private let starling = Starling()
    
    init(type: TimerSound) {
        lowSound = type.lowSoundResource
        highSound = type.highSoundResource
        starling.load(resource: lowSound, type: "caf", for: lowSound)
        starling.load(resource: highSound, type: "caf", for: highSound)
    }
    
    /// Plays the low pitch variation of this sound player for seconds 3, 2, and 1. Plays the high pitch variation for second zero. Any
    /// other second will not trigger a sound to be played.
    /// - Parameter newSecondsLeft: The current second left in the timer for which to play the sound for
    func playSoundAt(newSecondsLeft: Int) {
        switch newSecondsLeft {
        case 3, 2, 1: playLowSound()
        case 0: playHighSound()
        default: return
        }
    }
    
    /// Plays the low pitch variation of this sound player
    func playLowSound() {
        starling.play(lowSound)
    }
    
    /// Plays the high pitch variation of this sound player
    func playHighSound() {
        starling.play(highSound)
    }
}
