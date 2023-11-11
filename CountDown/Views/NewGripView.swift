//
//  NewGripView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/2/23.
//

import SwiftUI
import CoreData

/// Provides a form and a toolbar to add a new grip to the workout
struct NewGripView: View {
    @ObservedObject var workout: Workout
    @State private var newGrip: GripViewModel
    @Binding var isShowingNewGripSheet: Bool
    @StateObject var errorMessages = ErrorMessages()

    init(context: NSManagedObjectContext, workout: Workout, isShowingNewGripSheet: Binding<Bool>) {
        _workout = ObservedObject(wrappedValue: workout)
        _newGrip = State(wrappedValue: GripViewModel(workout: workout, context: context))
        _isShowingNewGripSheet = isShowingNewGripSheet
    }
    
    var body: some View {
        NavigationStack {
            GripEditForm(grip: $newGrip, errorMessages: errorMessages)
                .navigationTitle("Add Grip")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isShowingNewGripSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            if formIsValidated() {
                                newGrip.save()
                                isShowingNewGripSheet = false
                            }
                        }
                    }
                }
        }
    }
    
    /// Returns true if form has no input errors and false otherwise
    private func formIsValidated() -> Bool {
        var isValidated = true
        errorMessages.clearErrors()

        if newGrip.gripType == nil {
            errorMessages.addError("Grip Type must be specified")
            isValidated = false
        }

        if let edgeSize = newGrip.edgeSize {
            if edgeSize < 1 || edgeSize > 50 {
                errorMessages.addError("Edge size must be between 1 and 50")
                isValidated = false
            }
        }
        
        return isValidated
    }
}

struct NewGripView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var workout: Workout = {
        let workoutType = WorkoutType(context: context)
        workoutType.name = "powerEndurance"
        
        let workout = Workout(context: context)
        workout.name = "Repeaters"
        workout.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout.createdDate = Date()
        workout.workoutType = workoutType
        return workout
    }()
    
    static var previews: some View {
        NewGripView(context: context, workout: workout, isShowingNewGripSheet: .constant(true))
    }
}
