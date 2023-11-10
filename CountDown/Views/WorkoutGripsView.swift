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
    @FetchRequest private var grips: FetchedResults<Grip>

    
    init(workout: Workout) {
        self.workout = workout
        _grips = FetchRequest<Grip>(
            sortDescriptors: [NSSortDescriptor(key: "sequenceNum", ascending: true)],
            predicate: NSPredicate(format: "workout == %@", workout))
    }
    
    var body: some View {
        Group {
            if grips.count == 0 {
                Text("No grips added yet")
                    .font(.headline)
            } else {
                List {
                    ForEach(0..<grips.count, id: \.self) { index in
                        GripCardView(
                            grip: grips[index],
                            titleColor: getColorFromWorkoutType(workoutType: workout.workoutType),
                            gripIndex: index)
                    }
                    .onDelete(perform: deleteGrips)
                    .onMove(perform: move)
                }
            }
        }
        .toolbar {
            HStack {
                EditButton()
                Button(action: {
                    isShowingNewGripSheet = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add Grip")
            }
        }
        .sheet(isPresented: $isShowingNewGripSheet) {
            NewGripView(context: moc, workout: workout, isShowingNewGripSheet: $isShowingNewGripSheet)
        }
        .navigationTitle("Grips")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /// Deletes the grips at the given offsets
    /// - Parameter offsets: The index set of all grips to delete
    private func deleteGrips(at offsets: IndexSet) {
        /*
         Add slight delay to prevent SwiftUI deletion bug. Bug not fixed as of 11/6/23.
         Taken from following source:
         https://stackoverflow.com/questions/60358948/swiftui-delete-row-in-list-with-context-menu-ui-glitch
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            for index in offsets {
                moc.delete(grips[index])
            }
        }
        
        try? moc.save()
    }
    
    /// Reorders a grip in the grips array
    ///
    /// Adapted from the following source:
    /// https://stackoverflow.com/questions/65804686/core-data-environment-managedobjectcontext-onmove
    /// - Parameters:
    ///   - source: The set of indexes to start the move from
    ///   - destination: The destination index
    private func move(from source: IndexSet, to destination: Int) {
        var revisedGrips: [Grip] = grips.map {$0}
        revisedGrips.move(fromOffsets: source, toOffset: destination)

        for index in 0..<revisedGrips.count {
            revisedGrips[index].sequenceNum = Int16(index)
        }
        
        try? moc.save()
    }
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
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
