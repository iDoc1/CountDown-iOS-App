//
//  AVPlayer+Beep.swift
//  CountDown
//
//  Created by Ian Docherty on 10/1/23.
//

import Foundation
import AVFoundation

extension AVPlayer {
    
    /// Returns an AVPlayer for a specific resource specified by the given sound type and pitch
    /// - Parameters:
    ///   - type: The TimerSound type corresponding to a pair of sound files in the Resources folder
    ///   - isHighPitch: Whether or not to play the high or low pitch of the given sound type
    /// - Returns: An AVPlayer for the specified sound type and pitch
    static func soundPlayer(type: TimerSound, isHighPitch: Bool) -> AVPlayer {
        let resource = isHighPitch ? "\(type.rawValue)_high" : "\(type.rawValue)_low"
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "caf") else {
            fatalError("Failed to find sound file")
        }
        return AVPlayer(url: url)
    }
}
