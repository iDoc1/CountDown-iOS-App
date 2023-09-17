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
            
        case .started:
            VStack {
                TimerButton(
                    action: { },
                    title: "Pause",
                    systemImage: "pause.fill",
                    color: Theme.mediumYellow.mainColor)
                .padding(.horizontal)
                ResetAndSkipButtons(resetAction: {}, skipAction: {})
            }
            
        case .paused:
            VStack {
                TimerButton(
                    action: { },
                    title: "Resume",
                    systemImage: "play.fill",
                    color: Theme.lightGreen.mainColor)
                .padding(.horizontal)
                ResetAndSkipButtons(resetAction: {}, skipAction: {})
            }
        }
    }
    
    /// Buttons to rest timer or skip to next element displayed in a single row
    private struct ResetAndSkipButtons: View {
        let resetAction: () -> Void
        let skipAction: () -> Void
        
        var body: some View {
            HStack {
                TimerButton(
                    action: resetAction,
                    title: "Reset",
                    systemImage: "arrow.counterclockwise",
                    color: Theme.brightRed.mainColor)
                .padding()
                
                TimerButton(
                    action: skipAction,
                    title: "Skip",
                    systemImage: "chevron.forward.2",
                    color: Theme.lightBlue.mainColor)
                .padding()
            }
        }
    }
}

struct TimerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TimerButtonsView(timerState: CountdownTimer.TimerState.started, startTimerAction: {})
    }
}
