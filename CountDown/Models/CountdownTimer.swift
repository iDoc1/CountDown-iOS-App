//
//  CountdownTimer.swift
//  CountDown
//
//  Created by Ian Docherty on 9/12/23.
//

import Foundation


/// Keeps the time left in the countdown, the current timer state, and provides various functions to change the state of the timer. Many
/// aspects of this class were inspired by both the Apple's SwiftUI Scrumdinger tutorial and the following source:
/// https://digitalbunker.dev/recreating-the-ios-timer-in-swiftui/


@MainActor
final class CountdownTimer: ObservableObject {
    /// The different states of activity a timer can have
    enum TimerState {
        case notStarted
        case started
        case paused
        case resumed
        case completed
    }
    
    /// The current activity state of the timer. Initially begins as notStarted.
    @Published var timerState = TimerState.notStarted {
        didSet {
            switch timerState {
            case .notStarted:
                timer.invalidate()
                secondsLeft = startSeconds
                secondsElapsed = 0.0
                progress = 1.0
            case .started:
                secondsLeft = startSeconds
                secondsElapsed = 0.0
                startTimer()
            case .paused:
                timer.invalidate()
            case .resumed:
                startTimer()
            case .completed:
                timer.invalidate()
            }
        }
    }
    
    /// The current integer number of seconds left in the countdown
    @Published var secondsLeft: Int = 75
    /// The percent completion of the current timer. A value of 1.0 means the countdown has not started. A value of zero means the
    /// countdown has completed.
    @Published var progress: Double = 1.0
    /// The index of the current grip in the DurationArray
    @Published var gripIndex: Int = 0
    /// The index of the current set within the current workout grip
    @Published var setIndex: Int = 0
    /// The index of the current rep within the current workout set
    @Published var repIndex: Int = 0
    
    /// The number of seconds the timer starts at
    var startSeconds: Int = 75
    /// The decimal number of seconds that have passed since the current countdown started
    var secondsElapsed: Double = 0.0
    /// A string representation of the time left in form "mm:ss"
    var timerString: String {
        let minutes = secondsLeft / 60
        let seconds = secondsLeft % 60
        // Add a leading zero to seconds if seconds does not have two digits
        return seconds > 9 ? "\(minutes):\(seconds)" : "\(minutes):0\(seconds)"
    }
    /// The frequency at which the timer will update
    var timeInterval: TimeInterval { 1.0 / 10.0}
    
    /// The timer that keeps track of the countdown
    private var timer = Timer()

    func startTimer() {
        // Timer interval set to update every one second
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
        timer.tolerance = 0.1
    }
    
    /// Updates variables related to the timer state
    nonisolated private func updateTimer() {
        Task { @MainActor in
            secondsElapsed += timeInterval
            
            // Only update secondsLeft if it has changed since the last timer update
            let newSecondsLeft = startSeconds - Int(secondsElapsed)
            if newSecondsLeft != secondsLeft {
                secondsLeft = newSecondsLeft
            }
            
            progress = (Double(startSeconds) - secondsElapsed) / Double(startSeconds)
            
            if secondsLeft <= 0 {
                timerState = TimerState.completed
            }
        }
    }
}
