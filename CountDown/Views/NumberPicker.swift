//
//  NumberPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// An HStack that allows the user to change the given value by either editing using the textfield or using the stepper buttons.
struct NumberPicker: View {
    @Binding var number: Int
    let title: String
    var minVal: Int
    var maxVal: Int
    var isInputActive: FocusState<Bool>.Binding
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }

    var body: some View {
        // The following was code adapted from: https://developer.apple.com/forums/thread/126268
        HStack {
            Text(title)
            Spacer()
            TextField("", value: $number, formatter: numberFormatter)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minWidth: 15, maxWidth: 60)
                .focused(isInputActive)
            Stepper(title, value: $number, in: minVal...maxVal)
                .labelsHidden()
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(number: .constant(1), title: "Sets", minVal: 1, maxVal: 30, isInputActive: FocusState<Bool>().projectedValue)
    }
}
