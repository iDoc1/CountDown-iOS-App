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
                Text("Decrement Sets")
            }
        } header: {
            Text("Sets & Reps")
        } footer: {
            Text("Decrementing the sets will reduce the number of reps in even-numbered sets by one rep")
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
                isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
