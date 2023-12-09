//
//  WorkoutEditView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/11/23.
//

import SwiftUI
import CoreData

/// Provides a form to edit an existing workout
struct WorkoutEditView: View {
    @State private var workout: WorkoutViewModel
    @Binding var isShowingEditWorkoutSheet: Bool
    @StateObject var errorMessages = ErrorMessages()
    
    init(context: NSManagedObjectContext, workout: Workout, isShowingEditWorkoutSheet: Binding<Bool>) {
        _workout = State(wrappedValue: WorkoutViewModel(workout: workout, context: context))
        _isShowingEditWorkoutSheet = isShowingEditWorkoutSheet
    }
    var body: some View {
        NavigationStack {
            WorkoutEditForm(workout: $workout, errorMessages: errorMessages)
                .navigationTitle("Edit Workout")
                .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isShowingEditWorkoutSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        if workoutIsValidated(workout: workout, errorMessages: errorMessages) {
                            workout.save()
                            isShowingEditWorkoutSheet = false
                        }
                    }
                }
            }
        }
    }
}

//struct WorkoutEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutEditView()
//    }
//}
