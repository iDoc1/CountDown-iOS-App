//
//  SetsRepsSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A section containing pickers and a toggle to choose the number of sets and reps, and the Decrement Sets boolean value
struct SetsRepsSection: View {
    @Binding var sets: Int
    @Binding var reps: Int
    @Binding var decrementSets: Bool
    @Binding var hasCustomDurations: Bool
    @State private var isShowingDecrementPopover = false
    @State private var isShowingDurationsPopover = false
    var isInputActive: FocusState<Bool>.Binding
    
    
    var body: some View {
        Section {
            NumberPicker(
                number: $sets,
                title: "Sets",
                minVal: 1,
                maxVal: 20,
                isInputActive: isInputActive)
            NumberPicker(
                number: $reps,
                title: "Reps",
                minVal: 1,
                maxVal: 20,
                isInputActive: isInputActive)
            Toggle(isOn: $decrementSets) {
                HStack {
                    Text("Decrement Sets")
                    InfoButtonWithPopover(
                        text: "Decrementing the sets reduces the number of reps in even-numbered " +
                        "sets by one rep. For example, in a workout with 4 sets of 5 reps, the " +
                        "number of reps will have the pattern 5 -> 4 -> 5 -> 4.")
                }
            }
            Toggle(isOn: $hasCustomDurations) {
                HStack {
                    Text("Custom Durations")
                    InfoButtonWithPopover(
                        text: "Enables different work and rest durations to be specified for each " +
                        "rep. This is expecially useful for ladder workouts.")
                }
            }
        } header: {
            Text("Sets & Reps")
        }
    }
}

struct SetsRepsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SetsRepsSection(
                sets: .constant(3),
                reps: .constant(5),
                decrementSets: .constant(true),
                hasCustomDurations: .constant(true),
                isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
