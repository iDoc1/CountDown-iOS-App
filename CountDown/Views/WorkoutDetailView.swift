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
                
                sectionRow(title: "Name", text: workout.unwrappedName)
                sectionRow(
                    title: "Type",
                    text: WorkoutTypeAsString(
                        rawValue: workout.unwrappedWorkoutTypeName)?.displayName ?? "",
                    color: getColorFromWorkoutType(workoutType: workout.workoutType))
                sectionRow(title: "Description", text: workout.unwrappedDescriptionText)
                sectionRow(title: "Hangboard", text: workout.unwrappedHangboardName)
                NavigationLink(destination: WorkoutGripsView()) {
                    sectionRow(title: "Grips", text: "5 added")
                }
            }

            Section(header: Text("History")) {
                Label("No workouts yet", systemImage: "calendar.badge.exclamationmark")
            }
        }
        .navigationTitle(workout.unwrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /// Returns an HStack with a title on the left and text on the right
    /// - Parameters:
    ///   - title: The title to show in black font on the left
    ///   - text: The text to show in gray on the right
    /// - Returns: An HStack view
    private func sectionRow(
        title: String,
        text: String,
        color: Color = Color(.systemGray)
    ) -> some View {
        return HStack {
            Text(title)
            Spacer()
            Text(text)
                .foregroundColor(color)
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
        return workout
    }()
    
    static var previews: some View {
        NavigationStack {
            WorkoutDetailView(workout: workout)
        }
    }
}
