//
//  NewWorkoutSheet.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI
import CoreData

struct NewWorkoutSheet: View {
    @State var newWorkout: WorkoutViewModel
    @Binding var isShowingNewWorkoutSheet: Bool
    @StateObject var errorMessages = ErrorMessages()
    
    init(context: NSManagedObjectContext, isShowingNewWorkoutSheet: Binding<Bool>) {
        _newWorkout = State(wrappedValue: WorkoutViewModel(context: context))
        _isShowingNewWorkoutSheet = isShowingNewWorkoutSheet
    }
    
    var body: some View {
        NavigationStack {
            WorkoutEditView(workout: $newWorkout, errorMessages: errorMessages)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isShowingNewWorkoutSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if formIsValidated() {
                            newWorkout.save()
                            isShowingNewWorkoutSheet = false
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

        if newWorkout.name.isEmpty {
            errorMessages.addError("Name field cannot be empty")
            isValidated = false
        }
        
        if newWorkout.description.isEmpty {
            errorMessages.addError("Description field cannot be empty")
            isValidated = false
        }
        
        return isValidated
    }
}

struct NewWorkoutSheet_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var previews: some View {
        NewWorkoutSheet(context: context, isShowingNewWorkoutSheet: .constant(true))
    }
}
