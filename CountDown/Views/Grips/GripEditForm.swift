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
            GripTypeSection(
                grip: $grip,
                errorMessages: errorMessages,
                isInputActive: $isInputActive)
            SetsRepsSection(
                sets: $grip.setCount,
                reps: $grip.repCount,
                decrementSets: $grip.decrementSets,
                isInputActive: $isInputActive)
            
            Section {
                RepDurationsPicker(
                    workSeconds: $grip.workSeconds,
                    restSeconds: $grip.restSeconds,
                    isInputActive: $isInputActive)
                BreakDurationPicker(
                    breakMinutes: $grip.breakMinutes,
                    breakSeconds: $grip.breakSeconds,
                    showBreakPicker: $showBreakPicker,
                    title: "Break")
                BreakDurationPicker(
                    breakMinutes: $grip.lastBreakMinutes,
                    breakSeconds: $grip.lastBreakSeconds,
                    showBreakPicker: $showLastBreakPicker,
                    title: "Last Break")
            } header: {
                Text("Durations")
            } footer: {
                Text("Last Break occurs between this grip and the next. It is ignored if this grip is last in the workout.")
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
