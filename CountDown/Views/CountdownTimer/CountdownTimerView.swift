//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI

/// Displays the countdown timer buttons, circular progress indicator, and timer progress trackers. This view is specifically for
/// countdown timers created from the Timer Setup screen.
struct CountdownTimerView: View {
    @StateObject private var countdownTimer: CountdownTimer
    
    init(gripsArray: GripsArray) {
        _countdownTimer = StateObject(wrappedValue: CountdownTimer(gripsArray: gripsArray))
    }

    var body: some View {
        VStack {
            TimerHeader(timer: countdownTimer)
            TimerView(timer: countdownTimer)
                .overlay {
                    TimerTextView(timer: countdownTimer)
                }
            TimerButtonsView(timer: countdownTimer)
                .frame(height: 100.0)
        }
        .onDisappear {
            countdownTimer.timerState = .notStarted
            enableSleepMode()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 45)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        CountdownTimerView(gripsArray: gripsArray)
    }
}
