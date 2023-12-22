//
//  EditGripView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/9/23.
//

import SwiftUI
import CoreData

/// A view to edit an existing grip
struct GripEditView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var grip: Grip
    @State private var gripModel: GripViewModel
    @Binding var isShowingEditGripSheet: Bool
    @StateObject var errorMessages = ErrorMessages()

    init(context: NSManagedObjectContext, grip: Grip, isShowingEditGripSheet: Binding<Bool>) {
        self.grip = grip
        self.gripModel = GripViewModel(grip: grip)
        _isShowingEditGripSheet = isShowingEditGripSheet
    }

    var body: some View {
        NavigationStack {
            GripEditForm(grip: $gripModel, errorMessages: errorMessages)
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
                            if gripIsValidated(grip: gripModel, errorMessages: errorMessages) {
                                gripModel.saveAsGrip(workout: grip.workout!, context: moc)
                                isShowingEditGripSheet = false
                            }
                        }
                    }
                }
        }
    }
}

struct GripEditView_Previews: PreviewProvider {
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
        GripEditView(context: context, grip: grip, isShowingEditGripSheet: .constant(true))
    }
}
