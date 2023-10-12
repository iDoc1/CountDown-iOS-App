//
//  TimerSound.swift
//  CountDown
//
//  Created by Ian Docherty on 10/9/23.
//

import Foundation

/// The names of the timer sounds available to the user. Each sound should correspond to a sound file in the Resources folder.
enum TimerSound: String, CaseIterable, Identifiable {
    case beep
    case buzzer
    case chime
    case electric
    case glass
    
    /// Returns a string representation with the first letter capitalized
    var displayName: String {
        let rawString = rawValue
        return rawString.prefix(1).uppercased() + rawString.lowercased().dropFirst()
    }
    
    var id: String {
        rawValue
    }
}
