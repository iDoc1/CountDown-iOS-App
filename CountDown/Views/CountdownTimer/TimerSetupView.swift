//
//  TimerSetupView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// Allows the user to set timer values for a custom timer setup, then navigate to a page to start the timer
struct TimerSetupView: View {
    @State private var grip = GripViewModel()
    @State private var dualHand = DualHandSettings()
    @FocusState private var isInputActive: Bool
    @State var showPicker = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SetsRepsPickers(
                        grip: $grip,
                        isInputActive: $isInputActive)
                } header: {
                    Text("Sets & Reps")
                }
                
                DualHandModeSection(
                    isLeftRightEnabled: $dualHand.isLeftRightEnabled,
                    startHand: $dualHand.startHand,
                    secondsBetweenHands: $dualHand.secondsBetweenHands,
                    handSwitchMode: $dualHand.handSwitchMode,
                    isInputActive: $isInputActive)
                
                if grip.hasCustomDurations {
                    RepDurationsPicker(
                        grip: $grip,
                        isInputActive: $isInputActive)
                    Section {
                        BreakDurationPicker(
                            breakMinutes: $grip.breakMinutes,
                            breakSeconds: $grip.breakSeconds,
                            showBreakPicker: $showPicker,
                            title: "Break")
                    } header: {
                        Text("Break Durations")
                    }
                } else {
                    Section {
                        RepDurationsPicker(
                            grip: $grip,
                            isInputActive: $isInputActive)
                        BreakDurationPicker(
                            breakMinutes: $grip.breakMinutes,
                            breakSeconds: $grip.breakSeconds,
                            showBreakPicker: $showPicker,
                            title: "Break")
                    } header: {
                        Text("Durations")
                    }
                }
                
                NavigationLink {
                    CountdownTimerView(gripsArray: GripsArray(grip: grip, dualHand: dualHand))
                } label: {
                    Label("Start Workout", systemImage: "play.fill")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Timer Setup")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            .onChange(of: grip.repCount) { newValue in
                // Do not show custom durations if user increases reps to an invalid quantity
                if newValue > maxNumberOfReps {
                    grip.hasCustomDurations = false
                }
            }
        }
    }
}

struct TimerSetupView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSetupView()
    }
}
