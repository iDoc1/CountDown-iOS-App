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
    @State private var editGripIndex = 0
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
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteGrip(at: index)
                            } label: {
                                Text("Delete")
                            }
                            Button {
                                let grip = grips[index]
                                withAnimation {
                                    grip.duplicate(with: moc)
                                }
                            } label: {
                                Text("Copy")
                            }
                            .tint(.indigo)
                        }
                    }
                    
                    .onMove(perform: move)
                }
                /**
                 This id is required to prevent a glitch where lists temporarily reverts to old order when a grip is moved. The
                 reasoning is explained very nicely in the following source:
                 https://www.hackingwithswift.com/articles/210/how-to-fix-slow-list-updates-in-swiftui
                 */
                .id(UUID())
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
    
    
    /// Deletes the grip at the given index
    /// - Parameter index: The index in the grips list to delete
    private func deleteGrip(at index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            moc.delete(grips[index])
        }
        do {
            try moc.save()
        } catch {
            print("Failed to delete grip: \(error)")
        }
    }
    
    /// Reorders a grip in the grips array
    ///
    /// Adapted from the following source:
    /// https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list
    /// - Parameters:
    ///   - source: The set of indexes to start the move from
    ///   - destination: The destination index
    private func move(from source: IndexSet, to destination: Int) {
        var revisedGrips: [Grip] = grips.map { $0 }
        revisedGrips.move(fromOffsets: source, toOffset: destination)
        
        // Modify sequence numbers for each grip
        for index in 0..<revisedGrips.count {
            revisedGrips[index].sequenceNum = Int16(index)
        }
        
        do {
            try moc.save()
        } catch {
            print("Failed to move grips: \(error)")
        }
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
        grip2.breakSeconds = 0
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
