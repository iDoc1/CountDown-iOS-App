//
//  CountdownTimer.swift
//  CountDown
//
//  Created by Ian Docherty on 9/12/23.
//

import Foundation
import SwiftUI

/// Keeps the time left in the countdown, the current timer state, and provides various functions to change the state of the timer. Some
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
                resetTimer()
            case .started:
                resetTimer()
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
    @Published var secondsLeft: Int
    /// The percent completion of the current timer. A value of 1.0 means the countdown has not started. A value of zero means the
    /// countdown has completed.
    @Published var progress: Double = 1.0
    /// The index of the current grip in the DurationArray
    @Published var gripIndex: Int = 0
    /// The index of the current DurationStatus in the current grip
    @Published var durationIndex: Int = 0

    /// The number of seconds the timer starts at
    var startSeconds: Int
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
    var timeInterval: TimeInterval { 1.0 / 10.0 }
    /// The color associated with the current duration
    var timerColor: Color {
        guard durationIndex < currGrip.durations.count else { return Theme.lightBlue.mainColor }
        return currGrip.durations[durationIndex].durationType.timerColor
    }
    /// The type of duration that ihe timer is counting down. Example: "WORK".
    var durationType: String {
        guard durationIndex < currGrip.durations.count else { return "COMPLETE" }
        return currGrip.durations[durationIndex].durationType.rawValue
    }
    
    /// The current WorkoutGrip
    private var currGrip: GripsArray.WorkoutGrip {
        guard gripIndex < gripsArray.count else { return GripsArray.WorkoutGrip(name: nil) }
        return gripsArray[gripIndex]
    }
    /// The timer that keeps track of the countdown
    private var timer = Timer()
    /// The array that contains a collection of grips that are fed into this timer
    private let gripsArray: GripsArray
    
    init(timerDetails: TimerSetupDetails) {
        self.gripsArray = GripsArray(timerDetails: timerDetails)
        // Set start seconds to the length of the first duration in the array
        self.startSeconds = self.gripsArray[0].durations[0].seconds
        self.secondsLeft = self.startSeconds
    }

    private func startTimer() {
        // Timer interval set to update every one second
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
        timer.tolerance = 0.1
    }
    
    /// Skips to the next grip and/or duration
    func skip() {
        progress = 1.0
        goToNextDuration()
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
                goToNextDuration()
            }
        }
    }
    
    /// Moves the timer to the next grip and/or duration. If there are none left, sets the timer state to completed.
    private func goToNextDuration() {
        // Check if a next DurationStatus exists
        if durationIndex + 1 < currGrip.durations.count {
            durationIndex += 1
            resetSeconds()

        /// Check if a next grip exists
        } else if gripIndex + 1 < gripsArray.grips.count {
            gripIndex += 1
            durationIndex = 0
            resetSeconds()

        } else {
            if gripIndex < gripsArray.grips.count && durationIndex < currGrip.durations.count {
                gripIndex += 1
                durationIndex += 1
                completeTimer()
            }
        }
    }
    
    /// Resets all CountdownTimer properties to initial state
    private func resetTimer() {
        gripIndex = 0
        durationIndex = 0
        progress = 1.0
        resetSeconds()
    }
    
    /// Resets the startSeconds, secondsLeft, and secondsElapsed to the initial state for a new duration
    private func resetSeconds() {
        startSeconds = currGrip.durations[durationIndex].seconds
        secondsLeft = startSeconds
        secondsElapsed = 0.0
    }
    
    /// Sets CountdownTimer properties to state of completion
    private func completeTimer() {
        secondsElapsed = 0.0
        secondsLeft = 0
        progress = 0.0
        timerState = .completed
    }
}
