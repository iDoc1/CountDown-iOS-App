//
//  CountdownTimer.swift
//  CountDown
//
//  Created by Ian Docherty on 9/12/23.
//

import Foundation


/// Keeps the time left in the countdown, the current timer state, and provides various functions to change the state of the timer


@MainActor
final class CountdownTimer: ObservableObject {
    /// The different states of activity a timer can have
    enum TimerState {
        case notStarted
        case started
        case paused
        case completed
    }
    
    /// The current integer number of seconds left in the countdown
    @Published var secondsLeft = 0
    /// The percent completion of the current timer. A  value of 1.0 means the countdown has not started. A value of zero means the
    /// countdown has completed.
    @Published var progress: Double = 1.0
    /// The current activity state of the timer. Initially begins as notStarted.
    @Published var timerState = TimerState.notStarted
    /// The number of seconds the timer starts at
    var startSeconds = 5
    /// The number of seconds left in decimal value
    var timeLeft: Double = 5
    /// A string representation of the time left in form "mm:ss"
    var timerString: String {
        let minutes = secondsLeft / 60
        let seconds = secondsLeft % 60
        // Add a leading zero to seconds if seconds does not have two digits
        return seconds > 9 ? "\(minutes):\(seconds)" : "\(minutes):0\(seconds)"
    }
    /// The timer that keeps track of the countdown
    private weak var timer: Timer?
    /// Used to keep track of when the current timer was started
    private var startDate: Date?
    /// The frequencey at which the timer will update
    var frequency: TimeInterval { 1.0 / 60.0}
    
    func startTimer() {
        timerState = TimerState.started
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
        timer?.tolerance = 0.1
        startDate = Date()
    }
    
    func stopTimer() {
        timerState = TimerState.notStarted
        timer?.invalidate()
    }
    
    /// Updates variables related to the timer state
    nonisolated private func updateTimer() {
        Task { @MainActor in
            guard let startDate, timerState == TimerState.started else { return }

            let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
            timeLeft = Double(startSeconds) - secondsElapsed
            
            // Only update seconds left if it has changed
            let newSecondsLeft = startSeconds - Int(secondsElapsed)
            if newSecondsLeft != secondsLeft {
                secondsLeft = newSecondsLeft
            }

            progress = (Double(startSeconds) - secondsElapsed) / Double(startSeconds)
            
            if progress <= 0 {
                timerState = TimerState.completed
            }
        }
    }
}
