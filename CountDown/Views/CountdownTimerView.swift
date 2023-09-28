//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI

/// Displays the countdown timer buttons, circular progress indicator, and timer progress trackers
struct CountdownTimerView: View {
    @StateObject private var countdownTimer: CountdownTimer
    
    init(timerDetails: TimerSetupDetails) {
        _countdownTimer = StateObject(wrappedValue: CountdownTimer(timerDetails: timerDetails))
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
        }
        .toolbar(.hidden, for: .tabBar)
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
        CountdownTimerView(timerDetails: timerDetails)
    }
}
