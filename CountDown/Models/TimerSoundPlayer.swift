//
//  TimerSoundPlayer.swift
//  CountDown
//
//  Created by Ian Docherty on 10/1/23.
//

import Foundation
import AVFoundation

/// Takes a TimerSound type then instantiates two AVPlayers for the high and low pitch sounds corresponding to the given sound type.
/// In addition, defines a playSound function to play the sound pitch corresponding to the number of seconds left in the countdown.
/// Typically, the countdown should play the low sound at seconds 3, 2, and 1, then the high sound at second zero.
class TimerSoundPlayer {
    private var lowBeepPlayer: AVPlayer
    private var highBeepPlayer: AVPlayer
    
    init(type: TimerSound) {
        // Set AudioSession options to provide low latency playback
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category and mode.
            try audioSession.setCategory(
                .playback,
                mode: .default,
                options: [.allowBluetoothA2DP])
            try audioSession.setPreferredIOBufferDuration(0.002)
        } catch {
            print("Failed to set the audio session configuration")
        }
        
        lowBeepPlayer = AVPlayer.soundPlayer(type: type, isHighPitch: false)
        highBeepPlayer = AVPlayer.soundPlayer(type: type, isHighPitch: true)
        lowBeepPlayer.seek(to: .zero)
        highBeepPlayer.seek(to: .zero)
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
        lowBeepPlayer.seek(to: .zero)
        DispatchQueue.global().async {
            self.lowBeepPlayer.play()
        }
        
    }
    
    /// Plays the high pitch variation of this sound player
    func playHighSound() {
        highBeepPlayer.seek(to: .zero)
        DispatchQueue.global().async {
            self.highBeepPlayer.play()
        }
    }
}
