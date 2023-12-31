//
//  TimerSound.swift
//  CountDown
//
//  Created by Ian Docherty on 10/9/23.
//

import Foundation
import Starling

/// The names of the timer sounds available to the user. Each sound should correspond to a CAF sound file in the Resources folder.
enum TimerSound: String, CaseIterable, Identifiable {
    case beep
    case electric
    case glass
    case strings
    case synth
    
    /// Returns a string representation with the first letter capitalized
    var displayName: String {
        let rawString = rawValue
        return rawString.prefix(1).uppercased() + rawString.lowercased().dropFirst()
    }
    
    var id: String {
        rawValue
    }
    
    /// The name of the file resource for the low sound
    var lowSoundResource: String {
        "\(rawValue)_low"
    }
    
    /// The name of the file resource for the high sound
    var highSoundResource: String {
        "\(rawValue)_high"
    }
}
