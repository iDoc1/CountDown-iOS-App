//
//  WorkoutsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

struct WorkoutsView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var isShowingNewWorkoutSheet = false
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.lastUsedDate)
    ]) private var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationStack {
            Group {
                if workouts.count == 0 {
                    Text("No workouts added yet")
                        .font(.headline)
                } else {
                    
                    List {
                        ForEach(workouts, id: \.self) { workout in
                            NavigationLink(destination: WorkoutDetailView()) {
                                WorkoutCardView(workout: workout)
                                    .tag(workout.objectID)
                            }
                        }
                        .onDelete(perform: deleteWorkouts)
                    }
                } 
            }
            .navigationTitle("Workouts")
            .toolbar {
                Button(action: {
                    isShowingNewWorkoutSheet = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Workout")
            }
        }
        .sheet(isPresented: $isShowingNewWorkoutSheet) {
            NewWorkoutSheet(context: moc, isShowingNewWorkoutSheet: $isShowingNewWorkoutSheet)
        }
    }
    
    /// Deletes the workouts at the given offsets then saves changes
    private func deleteWorkouts(at offsets: IndexSet) {
        for index in offsets {
            moc.delete(workouts[index])
        }
        
        do {
            try moc.save()
        } catch {
            // TODO: Handle error
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
