//
//  GripEditView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/2/23.
//

import SwiftUI

/// A view with a form to edit a given grip
struct GripEditForm: View {
    @Binding var grip: GripViewModel
    @FocusState private var isInputActive: Bool
    @State private var showBreakPicker = false
    @State private var showLastBreakPicker = false
    @ObservedObject var errorMessages: ErrorMessages

    var body: some View {
        Form {
            Section {
                NavigationLink(destination: GripTypePickerView(selectedGripType: $grip.gripType)) {
                    HStack {
                        Text("Grip Type")
                        Spacer()
                        Text(grip.gripType?.unwrappedName ?? "None")
                            .foregroundColor(Color(.systemGray))
                    }
                }
                HStack {
                    Text("Edge Size (mm)")
                    Spacer()
                    NumberTextField(number: $grip.edgeSize, isInputActive: $isInputActive)
                }
            } header: {
                Text("Grip Type")
            } footer: {
                errorMessages.errorView
            }
            
            Section {
                NumberPicker(
                    number: $grip.setCount,
                    title: "Sets",
                    minVal: 1,
                    maxVal: 20,
                    isInputActive: $isInputActive)
                NumberPicker(
                    number: $grip.repCount,
                    title: "Reps",
                    minVal: 1,
                    maxVal: 20,
                    isInputActive: $isInputActive)
                Toggle(isOn: $grip.decrementSets) {
                    Text("Decrement Sets")
                }
            } header: {
                Text("Sets & Reps")
            } footer: {
                Text("Decrementing the sets will reduce the number of reps in even-numbered sets by one rep")
            }
            
            Section {
                NumberPicker(
                    number: $grip.workSeconds,
                    title: "Work (sec.)",
                    minVal: 1,
                    maxVal: 60,
                    isInputActive: $isInputActive)
                NumberPicker(
                    number: $grip.restSeconds,
                    title: "Rest (sec.)",
                    minVal: 1,
                    maxVal: 60,
                    isInputActive: $isInputActive)
                TimePickerButton(
                    minute: $grip.breakMinutes,
                    second: $grip.breakSeconds,
                    showPicker: $showBreakPicker,
                    title: "Break")
                if showBreakPicker {
                    TimePicker(
                        minute: $grip.breakMinutes,
                        second: $grip.breakSeconds,
                        height: 125.0)
                }
                TimePickerButton(
                    minute: $grip.lastBreakMinutes,
                    second: $grip.lastBreakSeconds,
                    showPicker: $showLastBreakPicker,
                    title: "Last Break")
                if showLastBreakPicker {
                    TimePicker(
                        minute: $grip.lastBreakMinutes,
                        second: $grip.lastBreakSeconds,
                        height: 125.0)
                }
            } header: {
                Text("Durations")
            } footer: {
                Text("'Last Break' occurs between this grip and the next. It is ignored if this grip is last in the workout.")
            } .onChange(of: showBreakPicker) { isShowing in
                // Do not show last break picker if break picker is showing
                if isShowing {
                    withAnimation {
                        showLastBreakPicker = false
                    }
                    
                }
            } .onChange(of: showLastBreakPicker) { isShowing in
                // Do not show break picker if last break picker is showing
                if isShowing {
                    withAnimation {
                        showBreakPicker = false
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
}

struct GripEditForm_Previews: PreviewProvider {
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
        NavigationStack {
            GripEditForm(
                grip: .constant(GripViewModel(workout: workout, context: context)),
                errorMessages: ErrorMessages())
        }
    }
}
