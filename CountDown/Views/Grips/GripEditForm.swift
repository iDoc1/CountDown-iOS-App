//
//  GripEditView.swift
//  CountDown
//
//  Created by Ian Docherty on 11/2/23.
//

import SwiftUI

/// A view with a form to edit a given grip
struct GripEditForm: View {
    @Binding var grip: GripViewModel
    @FocusState private var isInputActive: Bool
    @State private var showBreakPicker = false
    @State private var showLastBreakPicker = false
    @ObservedObject var errorMessages: ErrorMessages
    
    var body: some View {
        Form {
            Section {
                GripTypePickers(
                    grip: $grip,
                    errorMessages: errorMessages,
                    isInputActive: $isInputActive)
            } header: {
                Text("Grip Type")
            } footer: {
                errorMessages.errorView
            }
            Section {
                SetsRepsPickers(
                    grip: $grip,
                    isInputActive: $isInputActive)
            } header: {
                Text("Sets & Reps")
            }
            
            Group {
                if grip.hasCustomDurations {
                    RepDurationsPicker(
                        grip: $grip,
                        isInputActive: $isInputActive)
                    Section {
                        BreakDurationPickers(
                            grip: $grip,
                            showBreakPicker: $showBreakPicker,
                            showLastBreakPicker: $showLastBreakPicker)
                    } header: {
                        Text("Break Durations")
                    } footer: {
                        Text("Last Break occurs between this grip and the next. It is ignored if this grip is last in the workout.")
                    }
                } else {
                    Section {
                        RepDurationsPicker(
                            grip: $grip,
                            isInputActive: $isInputActive)
                        BreakDurationPickers(
                            grip: $grip,
                            showBreakPicker: $showBreakPicker,
                            showLastBreakPicker: $showLastBreakPicker)
                    } header: {
                        Text("Durations")
                    } footer: {
                        Text("Last Break occurs between this grip and the next. It is ignored if this grip is last in the workout.")
                    }
                }
            } .onChange(of: showBreakPicker) { isShowing in
                // Do not show last break picker if break picker is showing
                if isShowing {
                    withAnimation {
                        showLastBreakPicker = false
                    }
                    
                }
            } .onChange(of: showLastBreakPicker) { isShowing in
                // Do not show break picker if last break picker is showing
                if isShowing {
                    withAnimation {
                        showBreakPicker = false
                    }
                }
            }
            
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
    
    struct BreakDurationPickers: View {
        @Binding var grip: GripViewModel
        @Binding var showBreakPicker: Bool
        @Binding var showLastBreakPicker: Bool
        
        var body: some View {
            BreakDurationPicker(
                breakMinutes: $grip.breakMinutes,
                breakSeconds: $grip.breakSeconds,
                showBreakPicker: $showBreakPicker,
                title: "Break")
            BreakDurationPicker(
                breakMinutes: $grip.lastBreakMinutes,
                breakSeconds: $grip.lastBreakSeconds,
                showBreakPicker: $showLastBreakPicker,
                title: "Last Break")
        }
    }
}

struct GripEditForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GripEditForm(
                grip: .constant(GripViewModel()),
                errorMessages: ErrorMessages())
        }
    }
}
