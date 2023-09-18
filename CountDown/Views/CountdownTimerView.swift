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
            TimerView(progress: countdownTimer.progress, animationDuration: countdownTimer.timeInterval)
                .overlay {
                    TimerTextView(timerString: countdownTimer.timerString)
                }
            TimerButtonsView(
                timerState: countdownTimer.timerState,
                startTimerAction: { countdownTimer.timerState = .started },
                pauseTimerAction: { countdownTimer.timerState = .paused },
                resumeTimerAction: { countdownTimer.timerState = .resumed },
                resetTimerAction: { countdownTimer.timerState = .notStarted }
            )
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
        CountdownTimerView()
    }
}
