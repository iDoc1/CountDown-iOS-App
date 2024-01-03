//
//  NumberPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// An view that allows the user to change the given value by either editing using the textfield or using the stepper buttons.
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
            TextField("", value: $number.animation(), formatter: numberFormatter)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minWidth: 15, maxWidth: 60)
                .focused(isInputActive)
            Stepper(title, value: $number.animation(), in: minVal...maxVal)
                .labelsHidden()
        }
        .onChange(of: number) { newValue in
            var newNumber = 1
            
            // Ensure that new value is within the min and max range
            if newValue < minVal {
                newNumber = minVal
            } else if newValue > maxVal {
                newNumber = maxVal
            } else {
                newNumber = newValue
            }
            
            number = newNumber
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(
            number: .constant(1),
            title: "Sets",
            minVal: 1,
            maxVal: 30,
            isInputActive: FocusState<Bool>().projectedValue)
    }
}
