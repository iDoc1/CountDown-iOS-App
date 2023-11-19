//
//  WorkoutDetailView.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI

/// Displays details about a specific workout and provides links to start a workout or edit the workout's grips
struct WorkoutDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var workout: Workout
    @State private var isShowingEditWorkoutSheet = false
    @FetchRequest private var grips: FetchedResults<Grip>

    var gripsArray: GripsArray {
        GripsArray(grips: Array(grips))
    }

    init(workout: Workout) {
        self.workout = workout
        _grips = FetchRequest<Grip>(
            sortDescriptors: [NSSortDescriptor(key: "sequenceNum", ascending: true)],
            predicate: NSPredicate(format: "workout == %@", workout))
    }
    
    var body: some View {
        List {
            NavigationLink(destination: CountdownTimerView(gripsArray: gripsArray)) {
                Label("Start Workout", systemImage: "play.fill")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            HStack {
                Label("Length", systemImage: "clock")
                Spacer()
                Text(secondsToLongString(seconds: gripsArray.totalSeconds))
                    .foregroundColor(Color(.systemGray))
            }
            
            Section(header: Text("Workout Grips")) {
                NavigationLink(destination: WorkoutGripsView(workout: workout)) {
                    SectionRow(title: "Grips", text: "\(workout.gripArray.count) added")
                }
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
                CreatedDateText(createdDate: workout.createdDate)
            }

            Section(header: Text("History")) {
                Label("No workouts yet", systemImage: "calendar.badge.exclamationmark")
            }
        }
        .toolbar {
            Button(action: {
                isShowingEditWorkoutSheet = true
            }) {
                Text("Edit")
            }
            .accessibilityLabel("Edit Workout")
        }
        .sheet(isPresented: $isShowingEditWorkoutSheet, content: {
            WorkoutEditView(
                context: moc,
                workout: workout,
                isShowingEditWorkoutSheet: $isShowingEditWorkoutSheet)
        })
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
    
    /// An HStack that displays the created date of the workout if that date exists
    struct CreatedDateText: View {
        let createdDate: Date?

        var body: some View {
            if createdDate != nil {
                return HStack {
                    Text("Date Created")
                    Spacer()
                    Text(createdDate!, style: .date)
                        .foregroundColor(Color(.systemGray))
                }
            } else {
                return HStack {
                    Text("Date Created")
                    Spacer()
                    Text("-")
                }
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
