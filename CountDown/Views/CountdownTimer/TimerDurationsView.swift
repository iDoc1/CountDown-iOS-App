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
    @State var fontType: Font? = nil
    
    private var currGrip: GripsArray.WorkoutGrip {
        timer.currGrip
    }
    
    var body: some View {
        VStack {
            TimeTextRow(
                title: "Work",
                time: currGrip.workTime,
                fontTypeOverride: fontTypeOverride)
            TimeTextRow(
                title: "Rest",
                time: currGrip.restTime,
                fontTypeOverride: fontTypeOverride)
            TimeTextRow(
                title: "Break",
                time: currGrip.breakTime,
                fontTypeOverride: fontTypeOverride)
        }
        .frame(maxWidth: 100.0)
    }
    
    /// Overrides the default font type within the time text rows if either the work or rest time
    /// strings exceed a predefined length. This ensures the work, rest, and break TimeTextRow
    /// font types are synchronized
    private var fontTypeOverride: Font? {
        let workTimeLength = currGrip.workTime.count
        let restTimeLength = currGrip.restTime.count
        
        if workTimeLength > 5 || restTimeLength > 5 {
            return .footnote
        }
        
        return nil
    }
}

struct TimerDurationsView_Previews: PreviewProvider {
    static var previews: some View {
        let gripsArray = GripsArray(grip: GripViewModel())
        let timer = CountdownTimer(gripsArray: gripsArray)
        
        TimerDurationsView(timer: timer)
    }
}
