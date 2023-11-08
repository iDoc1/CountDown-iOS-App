//
//  WorkoutGripsView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/1/23.
//

import SwiftUI

/// Allows user to create new new grips, add them to workout, and reorder grips in the workout
struct WorkoutGripsView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var workout: Workout
    @State private var isShowingNewGripSheet = false
    
    var body: some View {
        Group {
            if workout.gripArray.count == 0 {
                Text("No grips added yet")
                    .font(.headline)
            } else {
                List {
                    ForEach(0..<workout.gripArray.count, id: \.self) { index in
                        GripCardView(
                            grip: workout.gripArray[index],
                            titleColor: getColorFromWorkoutType(workoutType: workout.workoutType),
                            gripIndex: index)
                    }
                    .onDelete(perform: deleteGrips)
//                    .onMove(perform: move)
                }
            }
        }
        .toolbar {
            Button(action: {
                isShowingNewGripSheet = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Add Grip")
        }
        .sheet(isPresented: $isShowingNewGripSheet) {
            NewGripView(context: moc, workout: workout, isShowingNewGripSheet: $isShowingNewGripSheet)
        }
        .navigationTitle("Grips")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func deleteGrips(at offsets: IndexSet) {
        /*
         Add slight delay to prevent SwiftUI deletion bug. Bug not fixed as of 11/6/23.
         Taken from following source:
         https://stackoverflow.com/questions/60358948/swiftui-delete-row-in-list-with-context-menu-ui-glitch
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            for index in offsets {
                moc.delete(workout.gripArray[index])
            }
        }
        
        try? moc.save()
    }
    
//    private func move(from source: IndexSet, to destination: Int) {
//        grips.move(fromOffsets: source, toOffset: destination)
//    }
}

struct WorkoutGripsView_Previews: PreviewProvider {
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
        NavigationStack {
            WorkoutGripsView(workout: workout)
        }
    }
}
