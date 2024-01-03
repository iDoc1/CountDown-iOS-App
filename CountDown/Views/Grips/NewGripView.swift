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
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var workout: Workout
    @State private var newGrip = GripViewModel()
    @Binding var isShowingNewGripSheet: Bool
    @StateObject var errorMessages = ErrorMessages()
    
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
                            if gripIsValidated(grip: newGrip, errorMessages: errorMessages) {
                                newGrip.saveAsGrip(workout: workout, context: moc)
                                isShowingNewGripSheet = false
                            }
                        }
                        .accessibilityLabel("Confirm Add Grip")
                    }
                }
        }
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
        NewGripView(workout: workout, isShowingNewGripSheet: .constant(true))
    }
}
