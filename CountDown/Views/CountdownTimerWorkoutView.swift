//
//  TimerView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/19/23.
//

import SwiftUI

/// Displays the countdown timer buttons, circular progress indicator, and timer progress trackers. This view is specifically for
/// countdown timers created from a workout, as it displays both a grips progress stepper and the name of the current grip.
struct CountdownTimerWorkoutView: View {
    @Environment(\.managedObjectContext) private var moc
    @StateObject private var countdownTimer: CountdownTimer
    @ObservedObject var workout: Workout
    
    init(gripsArray: GripsArray, workout: Workout) {
        _countdownTimer = StateObject(wrappedValue: CountdownTimer(gripsArray: gripsArray))
        self.workout = workout
    }

    var body: some View {
        VStack {
            TimerHeader(timer: countdownTimer, showGripProgress: true)
            TimerGripTextView(timer: countdownTimer)
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
        .onChange(of: countdownTimer.timerState, perform: { newValue in
            // Save a history object on completion of the workout
            if newValue == .completed {
                var newHistory = WorkoutHistoryViewModel(
                    workout: workout,
                    totalSeconds: countdownTimer.totalSeconds,
                    context: moc)
                newHistory.save()
            }
        })
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CountdownTimerWorkoutView_Previews: PreviewProvider {
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
