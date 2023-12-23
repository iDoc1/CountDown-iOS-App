//
//  GripTypeSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A pair of pickers and form fields to choose the grip type and edge size for a grip
struct GripTypePickers: View {
    @Binding var grip: GripViewModel
    @ObservedObject var errorMessages: ErrorMessages
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        NavigationLink(destination: GripTypePickerView(selectedGripType: $grip.gripType)) {
            HStack {
                Text("Grip Type")
                Spacer()
                Text(grip.gripType?.unwrappedName ?? "None")
                    .foregroundColor(Color(.systemGray))
            }
        }
        .accessibilityIdentifier("gripTypesNavLink")
        
        HStack {
            Text("Edge Size (mm)")
            Spacer()
            NumberTextField(number: $grip.edgeSize, isInputActive: isInputActive)
        }
    }
}

struct GripTypeSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            GripTypePickers(
                grip: .constant(GripViewModel()),
                errorMessages: ErrorMessages(),
            isInputActive: FocusState<Bool>().projectedValue)
        }
    }
}
