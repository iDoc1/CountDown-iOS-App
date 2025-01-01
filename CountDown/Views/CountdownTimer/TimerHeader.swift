//
//  TimerHeader.swift
//  CountDown
//
//  Created by Ian Docherty on 9/26/23.
//

import SwiftUI

/// Provides details about the durations for the current grip and a progress stepper displaying how many grips, sets, and reps are
/// remaining in the workout
struct TimerHeader: View {
    @ObservedObject var timer: CountdownTimer
    let showGripProgress: Bool
    
    init(timer: CountdownTimer, showGripProgress: Bool = false) {
        self.timer = timer
        self.showGripProgress = showGripProgress
    }
    
    /// Whether or not the current set of reps should be shown as decremented by one
    var shouldDecrementReps: Bool {
        timer.currGrip.decrementSets && timer.currSet % 2 == 1
    }
    
    var body: some View {
        HStack {
            TimerDurationsView(timer: timer)
            Divider()
            Spacer()
            VStack {
                if showGripProgress {
                    ProgressStepper(
                        title: "Grips",
                        length: timer.totalGrips,
                        currIndex: timer.gripIndex,
                        color: Theme.lightGreen.mainColor,
                        isDecremented: false)
                }
                ProgressStepper(
                    title: "Sets",
                    length: timer.currGrip.totalSets,
                    currIndex: timer.currSet,
                    color: Theme.lightBlue.mainColor,
                    isDecremented: false)
                ProgressStepper(
                    title: "Reps",
                    length: timer.currGrip.totalReps,
                    currIndex: timer.currRep,
                    color: Theme.lightBlue.mainColor,
                    isDecremented: shouldDecrementReps)
            }
        }
        .frame(maxHeight: 110.0)
        .padding(.horizontal, 8)
    }
    
    
}

struct TimerHeader_Previews: PreviewProvider {
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
        grip1.breakSeconds = 30
        grip1.lastBreakMinutes = 2
        grip1.lastBreakSeconds = 15
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
        grip2.breakSeconds = 45
        grip2.lastBreakMinutes = 59
        grip2.lastBreakSeconds = 59
        grip2.edgeSize = 20
        grip2.sequenceNum = 3
        grip2.gripType = gripType2
        
        return workout
    }()

    static var previews: some View {
        let timer = CountdownTimer(gripsArray: GripsArray(grips: workout.gripArray, workout: workout))

        TimerHeader(timer: timer, showGripProgress: true)
    }
}
