//
//  TimerGripTextView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/19/23.
//

import SwiftUI

/// Dispalys the text of the current grip and next grip in the workout
struct TimerGripTextView: View {
    @ObservedObject var timer: CountdownTimer
    
    var body: some View {
        VStack {
            Text(timer.currGrip.name ?? "")
                .font(.title)
            if timer.nextGrip != nil {
                Text("Next Grip: \(timer.nextGrip?.name ?? "")")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

struct TimerGripTextView_Previews: PreviewProvider {
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
        TimerGripTextView(timer: CountdownTimer(gripsArray: GripsArray(grips: workout.gripArray)))
    }
}
