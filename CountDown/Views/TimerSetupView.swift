//
//  TimerSetupView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI
import Popovers

/// Allows the user to set timer values for a custom timer setup, then navigate to a page to start the timer
struct TimerSetupView: View {
    @State private var timerDetails = TimerSetupDetails()
    @FocusState private var isInputActive: Bool    
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Sets & Reps")) {
                    NumberPicker(
                        number: $timerDetails.sets,
                        title: "Sets",
                        minVal: 1,
                        maxVal: 20,
                        isInputActive: $isInputActive)
                    NumberPicker(
                        number: $timerDetails.reps,
                        title: "Reps",
                        minVal: 1,
                        maxVal: 20,
                        isInputActive: $isInputActive)
                }
                
                Section(header: Text("Durations")) {
                    NumberPicker(
                        number: $timerDetails.workSeconds,
                        title: "Work (sec.)",
                        minVal: 1,
                        maxVal: 60,
                        isInputActive: $isInputActive)
                    NumberPicker(
                        number: $timerDetails.restSeconds,
                        title: "Rest (sec.)",
                        minVal: 1,
                        maxVal: 60,
                        isInputActive: $isInputActive)
                    TimePickerPopover(
                        minute: $timerDetails.breakMinutes,
                        second: $timerDetails.breakSeconds,
                        title: "Break")
                }
                NavigationLink(destination: CountdownTimerView(timerDetails: timerDetails)) {
                    Label("Start Workout", systemImage: "play.fill")
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
