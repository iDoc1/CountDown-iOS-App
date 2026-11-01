//
//  Hand.swift
//  CountDown
//
//  Created by Ian Docherty on 12/15/24.
//

import Foundation

/**
 Represents either a left or right hand
 */
enum Hand: String, CaseIterable {
    case left = "Left"
    case right = "Right"
    
    /// Returns the opposite of the given hand
    var opposite: Hand {
        switch self {
        case .left: return .right
        case .right: return .left
        }
    }
}

/**
 Dual Hand Mode settings for timers that are not backed by a saved workout, such as the Timer Setup screen
 */
struct DualHandSettings: Equatable {
    var isLeftRightEnabled = false
    var startHand = Hand.left.rawValue
    var secondsBetweenHands = 10
    var handSwitchMode = HandSwitchMode.rep.rawValue
}

/**
 Specifies when hands are switched in Dual Hand Mode: after every rep or after every set
 */
enum HandSwitchMode: String, CaseIterable {
    case rep = "Rep"
    case set = "Set"
}
