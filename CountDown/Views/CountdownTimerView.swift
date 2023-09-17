//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI

/// Displays the countdown timer buttons, circular progress indicator, and timer progress trackers
struct CountdownTimerView: View {
    @StateObject var countdownTimer = CountdownTimer()

    var body: some View {
        VStack {
            TimerView(timer: countdownTimer)
            TimerButtonsView(
                timerState: countdownTimer.timerState,
                startTimerAction: countdownTimer.startTimer
            )
        }
        .onDisappear {
            countdownTimer.stopTimer()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView()
    }
}
