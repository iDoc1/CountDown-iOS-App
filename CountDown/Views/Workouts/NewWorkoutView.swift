//
//  NewWorkoutSheet.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI
import CoreData

/// Provides a form and a toolbar to add new workouts
struct NewWorkoutView: View {
    @State private var newWorkout: WorkoutViewModel
    @Binding var isShowingNewWorkoutSheet: Bool
    @StateObject var errorMessages = ErrorMessages()
    
    init(context: NSManagedObjectContext, isShowingNewWorkoutSheet: Binding<Bool>) {
        _newWorkout = State(wrappedValue: WorkoutViewModel(context: context))
        _isShowingNewWorkoutSheet = isShowingNewWorkoutSheet
    }
    
    var body: some View {
        NavigationStack {
            WorkoutEditForm(workout: $newWorkout, errorMessages: errorMessages)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isShowingNewWorkoutSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if workoutIsValidated(workout: newWorkout, errorMessages: errorMessages) {
                            newWorkout.save()
                            isShowingNewWorkoutSheet = false
                        }
                    }
                }
            }
        }
    }
}

struct NewWorkoutSheet_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        NewWorkoutView(context: context, isShowingNewWorkoutSheet: .constant(true))
    }
}
