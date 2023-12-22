//
//  TimerButtonsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// A series of buttons to start, stop, pause, reset and skip the countdown timer based on the current timer state
struct TimerButtonsView: View {
    @ObservedObject var timer: CountdownTimer

    var body: some View {
        switch timer.timerState {
            
        case .notStarted, .completed:
            VStack {
                TimerButton(
                    action: { timer.timerState = .started },
                    title: "Start",
                    systemImage: "play.fill",
                    color: Theme.lightBlue.mainColor)
                .padding(.horizontal)
                Spacer()
                    .frame(height: 35.0)
            }
            
        case .started, .resumed:
            VStack {
                TimerButton(
                    action: { timer.timerState = .paused },
                    title: "Pause",
                    systemImage: "pause.fill",
                    color: Theme.mediumYellow.mainColor)
                .padding(.horizontal)
                ResetAndSkipButtons
            }
            
        case .paused:
            VStack {
                TimerButton(
                    action: { timer.timerState = .resumed },
                    title: "Resume",
                    systemImage: "play.fill",
                    color: Theme.lightGreen.mainColor)
                .padding(.horizontal)
                ResetAndSkipButtons
            }
        }
    }
    
    /// Buttons to rest timer or skip to next element displayed in a single row
    var ResetAndSkipButtons: some View {
        HStack {
            TimerButton(
                action: { timer.timerState = .notStarted },
                title: "Reset",
                systemImage: "arrow.counterclockwise",
                color: Theme.brightRed.mainColor)
            .padding()
            
            TimerButton(
                action: { timer.skip() },
                title: "Skip",
                systemImage: "chevron.forward.2",
                color: Theme.lightBlue.mainColor)
            .padding()
        }
    }
}

struct TimerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let grip = GripViewModel()
        let gripsArray = GripsArray(grip: grip)
        let timer = CountdownTimer(gripsArray: gripsArray)

        TimerButtonsView(timer: timer)
    }
}
