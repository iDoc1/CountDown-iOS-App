//
//  HistoryGripCardView.swift
//  CountDown
//
//  Created by Ian Docherty on 12/4/23.
//

import SwiftUI

struct HistoryGripCardView: View {
    @ObservedObject var historyGrip: HistoryGrip
    var gripIndex: Int
    
    var body: some View {
        HStack {
            Text("\(gripIndex + 1)")
                .font(.title)
            Spacer(minLength: 15)
            VStack(alignment: .leading) {
                Text(historyGrip.unwrappedGripTypeName)
                    .font(.headline)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sets: \(historyGrip.unwrappedSetCount)")
                        Text("Reps: \(historyGrip.unwrappedRepCount)")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Work: \(historyGrip.unwrappedWorkSeconds)s")
                        Text("Rest: \(historyGrip.unwrappedRestSeconds)s")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Break: \(timeToString(minutes: historyGrip.unwrappedBreakMinutes, seconds: historyGrip.unwrappedBreakSeconds))")
                        Text("Break: \(timeToString(minutes: historyGrip.unwrappedLastBreakMinutes, seconds: historyGrip.unwrappedLastBreakSeconds)) (L)")
                    }
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(Color(.systemGray))
            }
        }
    }
}

struct HistoryGripCardView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var historyGrip: HistoryGrip = {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        
        let gripType = GripType(context: context)
        gripType.name = "Half Crimp"
        
        let grip = Grip(context: context)
        grip.workout = workout
        grip.setCount = 3
        grip.repCount = 6
        grip.workSeconds = 7
        grip.restSeconds = 3
        grip.breakMinutes = 1
        grip.breakSeconds = 30
        grip.edgeSize = 18
        grip.sequenceNum = 1
        grip.gripType = gripType
        
        let workoutHistory = WorkoutHistory(context: context)
        workoutHistory.workout = workout
        workoutHistory.totalSeconds = Int16(422)
        workoutHistory.workoutDate = Date()
        
        let historyGrip = HistoryGrip(context: context)
        historyGrip.workoutHistory = workoutHistory
        historyGrip.gripTypeName = grip.gripType?.name
        historyGrip.setCount = grip.setCount
        historyGrip.repCount = grip.repCount
        historyGrip.workSeconds = grip.workSeconds
        historyGrip.restSeconds = grip.restSeconds
        historyGrip.breakMinutes = grip.breakMinutes
        historyGrip.breakSeconds = grip.breakSeconds
        historyGrip.lastBreakMinutes = grip.lastBreakMinutes
        historyGrip.lastBreakSeconds = grip.lastBreakSeconds
        historyGrip.edgeSize = grip.edgeSize
        historyGrip.sequenceNum = grip.sequenceNum
        
        return historyGrip
    }()
    
    static var previews: some View {
        HistoryGripCardView(historyGrip: historyGrip, gripIndex: 1)
    }
}
