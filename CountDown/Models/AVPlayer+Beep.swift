//
//  AVPlayer+Beep.swift
//  CountDown
//
//  Created by Ian Docherty on 10/1/23.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let lowBeepPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "beep_low", withExtension: "wav") else {
            fatalError("Failed to find low beep sound file")
        }
        return AVPlayer(url: url)
    }()
}

extension AVPlayer {
    static let highBeepPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "beep_high", withExtension: "wav") else {
            fatalError("Failed to find high beep sound file")
        }
        return AVPlayer(url: url)
    }()
}
