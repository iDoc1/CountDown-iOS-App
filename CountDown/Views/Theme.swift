//
//  Theme.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Defines a set of color themes for the app
enum Theme: String {
    case lightBlue
    case lightGreen
    case brightRed
    case mediumYellow
    
    /// Returns the accent color corresponding to the main color
    var accentColor: Color {
        switch self {
        case .lightBlue, .lightGreen, .brightRed, .mediumYellow: return .white
        }
    }
    
    /// Returns the main color of the raw value
    var mainColor: Color {
        Color(rawValue)
    }
}
