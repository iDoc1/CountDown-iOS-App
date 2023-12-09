//
//  WorkoutsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// Shows all existing workouts amd provides a button to create new workouts
struct WorkoutsView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var isShowingNewWorkoutSheet = false
    @State private var showAlert = false
    @State private var workoutToDelete: Workout?
    
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
                            NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                WorkoutCardView(workout: workout)
                                    .tag(workout.objectID)
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button() {
                                    self.workoutToDelete = workout
                                    self.showAlert = true
                                } label: {
                                    Text("Delete")
                                }
                                .tint(.red)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Delete Workout"),
                                    message: Text("Are you sure you want to delete this workout?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        deleteWorkout()
                                    },
                                    secondaryButton: .cancel())
                            }
                        }
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
            NewWorkoutView(context: moc, isShowingNewWorkoutSheet: $isShowingNewWorkoutSheet)
        }
    }
    
    /// Deletes the selected workout
    private func deleteWorkout() {
        guard let workoutToDelete else { return }

        withAnimation {
            moc.delete(workoutToDelete)
        }
        
        do {
            try moc.save()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
