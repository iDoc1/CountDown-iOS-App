//
//  TimerButtonsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// A series of buttons to start, stop, pause, reset and skip the countdown timer based on the current timer state
struct TimerButtonsView: View {
    let timerState: CountdownTimer.TimerState
    let startTimerAction: @MainActor () -> ()
    let pauseTimerAction: @MainActor () -> ()
    let resumeTimerAction: @MainActor () -> ()
    let resetTimerAction: @MainActor () -> ()

    var body: some View {
        switch timerState {
            
        case .notStarted, .completed:
            VStack {
                TimerButton(
                    action: startTimerAction,
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
                    action: pauseTimerAction,
                    title: "Pause",
                    systemImage: "pause.fill",
                    color: Theme.mediumYellow.mainColor)
                .padding(.horizontal)
                ResetAndSkipButtons
            }
            
        case .paused:
            VStack {
                TimerButton(
                    action: resumeTimerAction,
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
                action: resetTimerAction,
                title: "Reset",
                systemImage: "arrow.counterclockwise",
                color: Theme.brightRed.mainColor)
            .padding()
            
            TimerButton(
                action: {},
                title: "Skip",
                systemImage: "chevron.forward.2",
                color: Theme.lightBlue.mainColor)
            .padding()
        }
    }
}

struct TimerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TimerButtonsView(
            timerState: CountdownTimer.TimerState.started,
            startTimerAction: {},
            pauseTimerAction: {},
            resumeTimerAction: {},
            resetTimerAction: {}
        )
    }
}
