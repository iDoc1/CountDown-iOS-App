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
                enableSleepMode()
            case .started:
                resetTimer()
                startTimer()
                disableSleepMode()
            case .paused:
                timer.invalidate()
                enableSleepMode()
            case .resumed:
                resumeTimer()
                disableSleepMode()
            case .completed:
                timer.invalidate()
                enableSleepMode()
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
    
    @AppStorage("soundType") private var soundType: TimerSound = .beep
    @AppStorage("timerSound") private var timerSoundOn = true

    /// The number of seconds the timer starts at
    var startSeconds: Int
    /// A string representation of the total length of the workout in the form "mm:ss"
    var totalTime: String {
        let totalMinutes = gripsArray.totalSeconds / 60
        let totalSeconds = gripsArray.totalSeconds % 60
        return timeToString(minutes: totalMinutes, seconds: totalSeconds)
    }
    /// A string representation of the time left in the workout in the form "mm:ss"
    var timeLeft: String {
        let secondsLeft = gripsArray.totalSeconds - totalSecondsElapsed
        let timeLeftMinutes = secondsLeft / 60
        let timeLeftSeconds = secondsLeft % 60
        return timeToString(minutes: timeLeftMinutes, seconds: timeLeftSeconds)
    }
    /// A string representation of the time left in form "mm:ss"
    var timerString: String {
        let minutes = secondsLeft / 60
        let seconds = secondsLeft % 60
        return timeToString(minutes: minutes, seconds: seconds)
    }
    /// The frequency at which the timer will update
    var timeInterval: TimeInterval { 1.0 / 20.0 }
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
    var currGrip: GripsArray.WorkoutGrip {
        guard gripIndex < gripsArray.count else {
            return gripsArray.last
        }
        return gripsArray[gripIndex]
    }
    /// The current set index for the current grip. Returns the total sets in the current grip if the workout is complete.
    var currSet: Int {
        guard gripIndex < gripsArray.count else {
            return gripsArray.last.totalSets
        }
        return gripsArray[gripIndex].durations[durationIndex].currSet
    }
    /// The current rep index for the current grip. Returns the total reps in the current grip if the workout is complete.
    var currRep: Int {
        guard gripIndex < gripsArray.count else {
            return gripsArray.last.totalReps
        }
        return gripsArray[gripIndex].durations[durationIndex].currRep
    }
    
    /// The timer that keeps track of the countdown
    private var timer = Timer()
    /// Plays the countdown beeps sounds
    private var soundPlayer: TimerSoundPlayer?
    /// The array that contains a collection of grips that are fed into this timer
    private let gripsArray: GripsArray
    /// Used to calculate the seconds elapsed since timer has started or resumed
    private var startDate = Date()
    /// The elapsed seconds for the entire workout so far
    private var totalSecondsElapsed: Int {
        // Return the total seconds in the workout if the workout has reached the end
        guard durationIndex < currGrip.durations.count else { return gripsArray.totalSeconds }
        return currGrip.durations[durationIndex].startSeconds + (startSeconds - secondsLeft)
    }
    
    init(timerDetails: TimerSetupDetails) {
        self.gripsArray = GripsArray(timerDetails: timerDetails)
        // Set start seconds to the length of the first duration in the array
        self.startSeconds = self.gripsArray[0].durations[0].seconds
        self.secondsLeft = self.startSeconds
        
        if timerSoundOn {
            self.soundPlayer = TimerSoundPlayer(type: soundType)
        }
        
    }
    
    /// Starts timer from the beginning. This is intended to only be executed when timer starts for the first time (not from a pause).
    private func startTimer() {
        startDate = Date()
        setUpAndStartTimer()
    }
    
    /// Resumes timer from a pause
    private func resumeTimer() {
        // Calculate the seconds elapsed using the current progress
        let secondsElapsed = Double(startSeconds) - (progress * Double(startSeconds))

        // Subtract seconds elapsed from current time because timer is already partially complete
        startDate = Date() - secondsElapsed
        setUpAndStartTimer()
    }
    
    /// Creates and starts a scheduled Timer
    private func setUpAndStartTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
        timer.tolerance = 0.01
    }
    
    /// Skips to the next grip and/or duration
    func skip() {
        progress = 1.0
        goToNextDuration()
    }
    
    /// Updates variables related to the timer state
    nonisolated private func updateTimer() {
        Task { @MainActor in
            let secondsElapsed = -startDate.timeIntervalSinceNow
            let newSecondsLeft = startSeconds - Int(secondsElapsed)
            
            // Only update secondsLeft if it has changed since the last timer update
            if newSecondsLeft != secondsLeft {
                Task {
                    await soundPlayer?.playSound(newSecondsLeft: newSecondsLeft)
                }
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
        /* The timer interval must be subtracted from the start date to prevent a delay any time the
         timer moves on to the next duration. For example, if the interval is 0.10 seconds then a
         0.10 second lag will occur when the timer moves to the next duration. This is because time
         of length timerInterval is consumed during transitions between durations, so this must
         be accounted for as to prevent the timer from drifting.
         */
        startDate = Date() - self.timeInterval
        startSeconds = currGrip.durations[durationIndex].seconds
        secondsLeft = startSeconds
    }
    
    /// Sets CountdownTimer properties to state of completion
    private func completeTimer() {
        secondsLeft = 0
        progress = 0.0
        timerState = .completed
    }
}
