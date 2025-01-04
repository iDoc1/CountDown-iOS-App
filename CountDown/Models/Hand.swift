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
