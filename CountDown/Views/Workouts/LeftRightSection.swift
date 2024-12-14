//
//  LeftRightSection.swift
//  CountDown
//
//  Created by Ian Docherty on 12/14/24.
//

import SwiftUI;

struct LeftRightSection: View {
    @State private var isLeftRightEnabled: Bool = false
    @State private var startWithHand: String = "Left"
    @State private var secondsBetweenHands: Int = 10;
    var isInputActive: FocusState<Bool>.Binding
    
    var body: some View {
        Section {
            Toggle(isOn: $isLeftRightEnabled.animation()) {
                Text("Left/Right Mode")
            }
            
            if isLeftRightEnabled {
                HStack(spacing: 20) {
                    Text("Start hand:")
                    Picker("Start hand:", selection: $startWithHand) {
                        Text("Left").tag("Left")
                        Text("Right").tag("Right")
                    }
                    .pickerStyle(.segmented)
                }
                
                HStack {
                    NumberPicker(
                        number: $secondsBetweenHands,
                        title: "Rest between hands (sec.)",
                        minVal: 1,
                        maxVal: 60,
                        isInputActive: isInputActive)
                }
            }
        } header: {
            Text("Grip Mode")
        } footer: {
            Text("Enables separate left/right hand per rep")
        }
    }
}

#Preview {
    List {
        LeftRightSection(isInputActive: FocusState<Bool>().projectedValue)
    }
}
