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
    @State var progress: Double = 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), style: StrokeStyle(lineWidth: 20.0))
            Circle()
                .trim(from: 0.0, to: progress)
                .rotation(Angle(degrees: -90))
                .stroke(
                    timer.timerColor,
                    style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
        }
        .padding(25)
        .onReceive(timer.$progress) { newValue in
            /*
             Only have non-zero animation duration if new progress less than current. This prevents
             the timer progress animation from moving backwards (clockwise) between duration changes.
             */
            let duration = newValue < progress ? timer.timeInterval : 0.0
            withAnimation(.linear(duration: duration)) {
                if newValue < progress {
                    progress = newValue
                } else {
                    // Reset progress to 1.0 if a duration change has occurred
                    progress = 1.0
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 45)
        let timer = CountdownTimer(timerDetails: timerDetails)
        
        TimerView(timer: timer)
    }
}
