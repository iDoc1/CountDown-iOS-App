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
                Section(header: Text("Durations")) {
                    RepDurationsPicker(
                        grip: $grip,
                        isInputActive: $isInputActive)
                    BreakDurationPicker(
                        breakMinutes: $grip.breakMinutes,
                        breakSeconds: $grip.breakSeconds,
                        showBreakPicker: $showPicker,
                        title: "Break")
                }
                NavigationLink {
                    CountdownTimerView(gripsArray: GripsArray(grip: grip))
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
        }
    }
}

struct TimerSetupView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSetupView()
    }
}
