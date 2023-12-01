//
//  WorkoutHistoryListView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/30/23.
//

import SwiftUI

/// A list of all the workout history associated with the given workout
struct WorkoutHistoryListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var workout: Workout
    @FetchRequest private var workoutHistory: FetchedResults<WorkoutHistory>

    init(workout: Workout) {
        self.workout = workout
        _workoutHistory = FetchRequest<WorkoutHistory>(
            sortDescriptors: [NSSortDescriptor(key: "workoutDate", ascending: false)],
            predicate: NSPredicate(format: "workout == %@", workout))
    }
    
    var body: some View {
        if workoutHistory.count == 0 {
            Label("No workouts yet", systemImage: "calendar.badge.exclamationmark")
        }
        ForEach(workoutHistory) { hist in
            HStack {
                Image(systemName: "calendar")
                Text(hist.unwrappedWorkouDate, style: .date)
                Text(hist.unwrappedWorkouDate, style: .time)
            }
        }
        .onDelete(perform: deleteHistory)
    }
    
    /// Deletes the workout history at the given offsets then saves changes
    private func deleteHistory(at offsets: IndexSet) {
        for index in offsets {
            withAnimation {
                moc.delete(workoutHistory[index])
            }
        }
        
        do {
            try moc.save()
        } catch {
            print("Failed to delete history: \(error)")
        }
    }
}

struct WorkoutHistoryListView_Previews: PreviewProvider {
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
        
        let workoutHistory = WorkoutHistory(context: context)
        workoutHistory.workout = workout
        workoutHistory.totalSeconds = Int16(420)
        workoutHistory.workoutDate = Date()
        
        return workout
    }()
    
    static var previews: some View {
        List {
            WorkoutHistoryListView(workout: workout)
        }
    }
}
