//
//  TimerDurationsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/27/23.
//

import SwiftUI

/// A stack of three rows displaying the work, rest, and break durations for the given timer
struct TimerDurationsView: View {
    @ObservedObject var timer: CountdownTimer
    
    private var currGrip: GripsArray.WorkoutGrip {
        timer.currGrip
    }
    
    var body: some View {
        VStack {
            TimeTextRow(title: "Work", time: currGrip.workTime)
            TimeTextRow(title: "Rest", time: currGrip.restTime)
            TimeTextRow(title: "Break", time: currGrip.breakTime)
        }
        .frame(maxWidth: 100.0)
    }
}

struct TimerDurationsView_Previews: PreviewProvider {
    static var previews: some View {
        let timerDetails = TimerSetupDetails(
            sets: 2,
            reps: 3,
            workSeconds: 7,
            restSeconds: 3,
            breakMinutes: 1,
            breakSeconds: 45)
        let gripsArray = GripsArray(timerDetails: timerDetails)
        let timer = CountdownTimer(gripsArray: gripsArray)
        
        TimerDurationsView(timer: timer)
    }
}
