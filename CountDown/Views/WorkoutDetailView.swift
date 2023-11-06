//
//  WorkoutDetailView.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI

/// Displays details about a specific workout and provides links to start a workout or edit the workout's grips
struct WorkoutDetailView: View {
    @ObservedObject var workout: Workout
    
    var body: some View {
        List {
            NavigationLink(destination: CountdownTimerView(timerDetails: TimerSetupDetails())) {
                Label("Start Workout", systemImage: "play.fill")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            HStack {
                Label("Length", systemImage: "clock")
                Spacer()
                Text("12 min 3 sec")
            }

            Section(header: Text("Workout Details")) {
                SectionRow(title: "Name", text: workout.unwrappedName)
                SectionRow(
                    title: "Type",
                    text: WorkoutTypeAsString(
                        rawValue: workout.unwrappedWorkoutTypeName)?.displayName ?? "",
                    color: getColorFromWorkoutType(workoutType: workout.workoutType))
                SectionRow(title: "Description", text: workout.unwrappedDescriptionText)
                SectionRow(title: "Hangboard", text: workout.unwrappedHangboardName)
                NavigationLink(destination: WorkoutGripsView(workout: workout)) {
                    SectionRow(title: "Grips", text: "\(workout.gripArray.count) added")
                }
            }

            Section(header: Text("History")) {
                Label("No workouts yet", systemImage: "calendar.badge.exclamationmark")
            }
        }
        .navigationTitle(workout.unwrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /// An HStack with a title on the left and text on the right
    struct SectionRow: View {
        let title: String
        let text: String
        var color: Color = Color(.systemGray)
        
        var body: some View {
            return HStack {
                Text(title)
                Spacer()
                Text(text)
                    .foregroundColor(color)
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
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
        
        return workout
    }()
    
    static var previews: some View {
        NavigationStack {
            WorkoutDetailView(workout: workout)
        }
    }
}
