//
//  TimerHeader.swift
//  CountDown
//
//  Created by Ian Docherty on 9/26/23.
//

import SwiftUI

/// Provides details about the durations for the current grip and a progress stepper displaying how many grips, sets, and reps are
/// remaining in the workout
struct TimerHeader: View {
    @ObservedObject var timer: CountdownTimer
    
    var body: some View {
        HStack {
            TimerDurationsView(timer: timer)
            Divider()
            Spacer()
        }
        .frame(maxHeight: 110.0)
        .padding(.horizontal)
    }
    
    
}

struct TimerHeader_Previews: PreviewProvider {
    static var previews: some View {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 45)
        let timer = CountdownTimer(timerDetails: timerDetails)

        TimerHeader(timer: timer)
    }
}
