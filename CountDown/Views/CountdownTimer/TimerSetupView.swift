//
//  TimerSetupView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// Allows the user to set timer values for a custom timer setup, then navigate to a page to start the timer
struct TimerSetupView: View {
    @State private var timerDetails = TimerSetupDetails()
    @FocusState private var isInputActive: Bool
    @State var showPicker = false
    
    var body: some View {
        NavigationStack {
            List {
                SetsRepsSection(
                    sets: $timerDetails.sets,
                    reps: $timerDetails.reps,
                    decrementSets: $timerDetails.decrementSets,
                    hasCustomDurations: $timerDetails.hasCustomDurations,
                    isInputActive: $isInputActive)
                
                Section(header: Text("Durations")) {
                    RepDurationsPicker(
                        workSeconds: $timerDetails.workSeconds,
                        restSeconds: $timerDetails.restSeconds,
                        isInputActive: $isInputActive)
                    BreakDurationPicker(
                        breakMinutes: $timerDetails.breakMinutes,
                        breakSeconds: $timerDetails.breakSeconds,
                        showBreakPicker: $showPicker,
                        title: "Break")
                }
                NavigationLink {
                    CountdownTimerView(gripsArray: GripsArray(timerDetails: timerDetails))
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
