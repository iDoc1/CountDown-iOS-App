//
//  EditGripView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/9/23.
//

import SwiftUI
import CoreData

/// A view to edit an existing grip
struct EditGripView: View {
    @State private var grip: GripViewModel
    @Binding var isShowingEditGripSheet: Bool
    @StateObject var errorMessages = ErrorMessages()

    init(context: NSManagedObjectContext, grip: Grip, isShowingEditGripSheet: Binding<Bool>) {
        self.grip = GripViewModel(workout: grip.workout!, grip: grip, context: context)
        _isShowingEditGripSheet = isShowingEditGripSheet
    }

    var body: some View {
        NavigationStack {
            GripEditForm(grip: $grip, errorMessages: errorMessages)
                .navigationTitle("Edit Grip")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isShowingEditGripSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            if formIsValidated() {
                                grip.save()
                                isShowingEditGripSheet = false
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

        if grip.gripType == nil {
            errorMessages.addError("Grip Type must be specified")
            isValidated = false
        }

        if let edgeSize = grip.edgeSize {
            if edgeSize < 1 || edgeSize > 50 {
                errorMessages.addError("Edge size must be between 1 and 50")
                isValidated = false
            }
        }
        
        return isValidated
    }
}

struct EditGripView_Previews: PreviewProvider {
    static let context = PersistenceController.preview.container.viewContext
    static var grip: Grip = {
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
        grip1.lastBreakMinutes = 59
        grip1.lastBreakSeconds = 59
        grip1.edgeSize = 18
        grip1.sequenceNum = 1
        grip1.gripType = gripType1
        
        return grip1
    }()

    static var previews: some View {
        EditGripView(context: context, grip: grip, isShowingEditGripSheet: .constant(true))
    }
}
