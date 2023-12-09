//
//  WorkoutEditView.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import SwiftUI
import Combine

/// A form with fields to enter information about a workout
struct WorkoutEditForm: View {
    @Binding var workout: WorkoutViewModel
    @ObservedObject var errorMessages: ErrorMessages

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $workout.name.max(40))
                TextField("Description", text: $workout.description.max(150))
                Picker("Workout Type", selection: $workout.workoutType) {
                    ForEach(WorkoutTypeAsString.allCases, id: \.self) { type in
                        Text(type.displayName)
                    }
                }
            } header: {
                Text("Workout Info")
            } footer: {
                errorMessages.errorView
            }

            Section(header: Text("Hangboard Info")) {
                TextField("Hangboard Name", text: $workout.hangboardName.max(50))
            }
        }
    }
}

struct WorkoutEditForm_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static let errors = {
        let errorMessages = ErrorMessages()
        errorMessages.addError("Name field cannot be empty")
        return errorMessages
    }()
    
    static var previews: some View {
        WorkoutEditForm(
            workout: .constant(WorkoutViewModel(context: context)),
            errorMessages: errors
        )
    }
}
