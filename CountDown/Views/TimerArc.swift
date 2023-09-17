//
//  TimerArc.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// The arc that shows how much time is left in the countdown. Takes a progress variable that specifies how much time is left as a
/// decimal number between 0.0 and 1.0 with 1.0 indicating that no time has passed. For example, a progress value of 0.75 would
/// return an arc that goes 75% around the circle.
struct TimerArc: Shape {
    let progress: Double
    
    private var startAngle: Angle {
        Angle(degrees: 0.0)
    }
    
    private var endAngle: Angle {
        Angle(degrees: progress * 360.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 20.0  // 20 is thickness of path
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false)
        }
    }
}
