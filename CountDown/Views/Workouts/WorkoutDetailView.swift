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
            NavigationLink(destination: CountdownTimerWorkoutView(
                gripsArray: gripsArray,
                workout: workout)
            ) {
                Label("Start Workout", systemImage: "play.fill")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            // Disable link if there are no grips in the workout yet
            .disabled(gripsArray.count <= 0)
            .accessibilityIdentifier("startWorkoutLink")
            
            HStack {
                Label("Length", systemImage: "clock")
                Spacer()
                Text(secondsToLongString(seconds: gripsArray.totalSeconds))
                    .foregroundColor(Color(.systemGray))
            }
            
            Section {
                NavigationLink(destination: WorkoutGripsView(workout: workout)) {
                    SectionRow(title: "Grips", text: "\(workout.gripArray.count) added")
                }
                .accessibilityIdentifier("addGripsNavLink")
            } header: {
                Text("Workout Grips")
            } footer: {
                Text("At least one grip must be added to start workout")
            }

            Section(header: Text("Workout Details")) {
                SectionRow(title: "Name", text: workout.unwrappedName)
                SectionRow(
                    title: "Type",
                    text: WorkoutTypeAsString(
                        rawValue: workout.unwrappedWorkoutTypeName)?.displayName ?? "",
                    color: getColorFromWorkoutType(workoutType: workout.workoutType))
                SectionRow(title: "Description", text: workout.unwrappedDescriptionText)
                // Do not show hangboard type if it is blank
                if workout.unwrappedHangboardName.count > 0 {
                    SectionRow(title: "Hangboard", text: workout.unwrappedHangboardName)
                }
                CreatedDateText(createdDate: workout.createdDate)
            }
            
            Section(header: Text("History")) {
                WorkoutHistoryListView(workout: workout)
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
