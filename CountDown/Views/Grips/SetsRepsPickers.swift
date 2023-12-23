//
//  SetsRepsSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A section containing pickers and a toggle to choose the number of sets and reps, and the Decrement Sets boolean value
struct SetsRepsPickers: View {
    @Binding var grip: GripViewModel
    @State private var isShowingDecrementPopover = false
    @State private var isShowingDurationsPopover = false
    var isInputActive: FocusState<Bool>.Binding
    
    
    var body: some View {
        NumberPicker(
            number: $grip.setCount,
            title: "Sets",
            minVal: 1,
            maxVal: 20,
            isInputActive: isInputActive)
        NumberPicker(
            number: $grip.repCount,
            title: "Reps",
            minVal: 1,
            maxVal: 20,
            isInputActive: isInputActive)
        Toggle(isOn: $grip.decrementSets) {
            HStack {
                Text("Decrement Sets")
                InfoButtonWithPopover(
                    text: "Decrementing the sets reduces the number of reps in even-numbered " +
                    "sets by one rep. For example, in a workout with 4 sets of 5 reps, the " +
                    "number of reps will have the pattern 5 -> 4 -> 5 -> 4.")
            }
        }
        Toggle(isOn: $grip.hasCustomDurations) {
            HStack {
                Text("Custom Durations")
                InfoButtonWithPopover(
                    text: "Enables different work and rest durations to be specified for each " +
                    "rep. This is especially useful for ladder workouts.")
            }
        }
    }
}

struct SetsRepsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SetsRepsPickers(
                grip: .constant(GripViewModel()),
                isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
