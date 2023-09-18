//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Displays the circular progress indicator for the timer with text in the center displaying the time left in the countdown
struct TimerView: View {
    let progress: Double
    let animationDuration: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), style: StrokeStyle(lineWidth: 20.0))
            Circle()
                .trim(from: 0.0, to: progress)
                .rotation(Angle(degrees: -90))
                .stroke(
                    Theme.lightBlue.mainColor,
                    style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
        }
        .padding(25)
        /// Causes an animation to occur over the given duration of time
        .animation(.linear(duration: animationDuration), value: progress)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(progress: 0.75, animationDuration: 0.10)
    }
}
