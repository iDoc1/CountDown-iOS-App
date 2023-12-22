//
//  RepDurationsPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A pair of number pickers to choose the work and rest durations for a single rep
struct RepDurationsPicker: View {
    @Binding var grip: GripViewModel
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Group {
            NumberPicker(
                number: $grip.workSeconds,
                title: "Work (sec.)",
                minVal: 1,
                maxVal: 60,
                isInputActive: isInputActive)
            NumberPicker(
                number: $grip.restSeconds,
                title: "Rest (sec.)",
                minVal: 1,
                maxVal: 60,
                isInputActive: isInputActive)
        }
        .onChange(of: grip.hasCustomDurations) { newValue in
            print("changed to custom")
        }
    }
}

struct RepDurationsPicker_Previews: PreviewProvider {
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
            Section {
                RepDurationsPicker(
                    grip: .constant(GripViewModel()),
                    isInputActive: FocusState<Bool>().projectedValue)
            }
        }
    }
}
