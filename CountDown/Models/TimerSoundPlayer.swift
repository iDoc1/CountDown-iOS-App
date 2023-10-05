//
//  TimerSoundPlayer.swift
//  CountDown
//
//  Created by Ian Docherty on 10/1/23.
//

import Foundation
import AVFoundation

class TimerSoundPlayer {
    private var lowBeepPlayer: AVPlayer  { AVPlayer.lowBeepPlayer }
    private var highBeepPlayer: AVPlayer  { AVPlayer.highBeepPlayer }
    
    func playSound(newSecondsLeft: Int) async {
        switch newSecondsLeft {
        case 3: playLowBeep()
        case 2: playLowBeep()
        case 1: playLowBeep()
        case 0: playHighBeep()
        default: return
        }
    }
    
    private func playLowBeep()  {
        lowBeepPlayer.seek(to: .zero)
        lowBeepPlayer.play()
    }
    
    private func playHighBeep()  {
        highBeepPlayer.seek(to: .zero)
        highBeepPlayer.play()
    }
}
