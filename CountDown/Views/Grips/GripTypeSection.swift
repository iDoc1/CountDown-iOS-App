//
//  GripTypeSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

struct GripTypeSection: View {
    @Binding var grip: GripViewModel
    @ObservedObject var errorMessages: ErrorMessages
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Section {
            NavigationLink(destination: GripTypePickerView(selectedGripType: $grip.gripType)) {
                HStack {
                    Text("Grip Type")
                    Spacer()
                    Text(grip.gripType?.unwrappedName ?? "None")
                        .foregroundColor(Color(.systemGray))
                }
            }
            .accessibilityIdentifier("gripTypesNavLink")
            
            HStack {
                Text("Edge Size (mm)")
                Spacer()
                NumberTextField(number: $grip.edgeSize, isInputActive: isInputActive)
            }
        } header: {
            Text("Grip Type")
        } footer: {
            errorMessages.errorView
        }
    }
}

struct GripTypeSection_Previews: PreviewProvider {
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
        List {
            GripTypeSection(
                grip: .constant(GripViewModel(workout: workout, context: context)),
                errorMessages: ErrorMessages(),
            isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
