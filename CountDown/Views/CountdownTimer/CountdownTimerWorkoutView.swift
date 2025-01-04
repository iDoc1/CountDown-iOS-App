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
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var countdownTimer: CountdownTimer
    @ObservedObject var workout: Workout
    
    init(gripsArray: GripsArray, workout: Workout) {
        _countdownTimer = StateObject(wrappedValue: CountdownTimer(gripsArray: gripsArray))
        self.workout = workout
    }

    var body: some View {
        VStack(spacing: 1) {
            TimerHeader(timer: countdownTimer, showGripProgress: true)
            TimerGripTextView(timer: countdownTimer)
            TimerView(timer: countdownTimer)
                .overlay {
                    TimerTextView(timer: countdownTimer)
                }
                .overlay(alignment: .top) {
                    TimerHandView(timer: countdownTimer)
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
        .navigationTitle(workout.unwrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: goBack, label: {
            Image(systemName: "chevron.left")
        }))
    }
    
    
    /// Navigates back to the previous screen
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct CountdownTimerWorkoutView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var workout: Workout = {
        let context = persistence.container.viewContext
        
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        workout.isLeftRightEnabled = true
        workout.startHand = Hand.left.rawValue
        
        let gripType1 = GripType(context: context)
        gripType1.name = "Half Crimp"
        let gripType2 = GripType(context: context)
        gripType2.name = "Three Finger Drag"
        
        let grip1 = Grip(context: context)
        grip1.workout = workout
        grip1.setCount = 3
        grip1.repCount = 6
        grip1.workSeconds = 7
        grip1.restSeconds = 3
        grip1.breakMinutes = 1
        grip1.breakSeconds = 0
        grip1.lastBreakMinutes = 1
        grip1.lastBreakSeconds = 59
        grip1.decrementSets = false
        grip1.hasCustomDurations = false
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        let grip2 = Grip(context: context)
        grip2.workout = workout
        grip2.setCount = 3
        grip2.repCount = 6
        grip2.workSeconds = 7
        grip2.restSeconds = 3
        grip2.breakMinutes = 1
        grip2.breakSeconds = 0
        grip2.lastBreakMinutes = 1
        grip2.lastBreakSeconds = 59
        grip2.decrementSets = false
        grip2.hasCustomDurations = false
        grip2.edgeSize = 20
        grip2.sequenceNum = 2
        grip2.gripType = gripType2
        
        return workout
    }()

    static var previews: some View {
        let gripsArray = GripsArray(grips: workout.gripArray, workout: workout)
        NavigationStack {
            CountdownTimerWorkoutView(gripsArray: gripsArray, workout: workout)
        }
    }
}
