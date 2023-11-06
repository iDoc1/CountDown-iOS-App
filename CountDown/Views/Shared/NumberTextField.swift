//
//  NumberTextField.swift
//  CountDown
//
//  Created by Ian Docherty on 11/4/23.
//

import SwiftUI

/// A text field that only allows numbers
struct NumberTextField: View {
    @Binding var number: Int?
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        TextField("optional", value: $number, format: .number)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .focused(isInputActive)
    }
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(number: .constant(3),
        isInputActive: FocusState<Bool>().projectedValue)
    }
}
