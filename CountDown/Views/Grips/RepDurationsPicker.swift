//
//  RepDurationsPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A pair of number pickers to choose the work and rest durations for a single rep
struct RepDurationsPicker: View {
    @Binding var workSeconds: Int
    @Binding var restSeconds: Int
    @Binding var hasCustomDurations: Bool
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Group {
            NumberPicker(
                number: $workSeconds,
                title: "Work (sec.)",
                minVal: 1,
                maxVal: 60,
                isInputActive: isInputActive)
            NumberPicker(
                number: $restSeconds,
                title: "Rest (sec.)",
                minVal: 1,
                maxVal: 60,
                isInputActive: isInputActive)
        }
        .onChange(of: hasCustomDurations) { newValue in
            print("changed to custom")
        }
    }
}

struct RepDurationsPicker_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                RepDurationsPicker(
                    workSeconds: .constant(3),
                    restSeconds: .constant(7),
                    hasCustomDurations: .constant(true),
                    isInputActive: FocusState<Bool>().projectedValue)
            }
        }
    }
}
