//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Displays the circular progress indicator for the timer with text in the center displaying the time left in the countdown
struct TimerView: View {
    @ObservedObject var timer: CountdownTimer
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .strokeBorder(Color(.systemGray5), lineWidth: 20.0)
                .overlay {
                    Text(timer.timerString)
                        .font(.system(size: geometry.size.height > geometry.size.width
                                      ? geometry.size.width * 0.3
                                      : geometry.size.height * 0.3))
                }
                .overlay {
                    TimerArc(progress: timer.progress)
                        .rotation(Angle(degrees: -90))
                        .stroke(
                            Theme.lightBlue.mainColor,
                            style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                }
                .padding(.horizontal)

        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let timer = CountdownTimer()
        TimerView(timer: timer)
    }
}
