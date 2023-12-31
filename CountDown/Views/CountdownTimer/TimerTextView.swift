//
//  TimerTextView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Text that displays the current time left in the countdown in format "mm:ss". Dynamically sizes the font based on the current width
/// and height available to this view.
struct TimerTextView: View {
    @ObservedObject var timer: CountdownTimer

    var body: some View {
        GeometryReader { geometry in
            Text(timer.timerString)
                .font(.system(size: customSize(geometry: geometry, factor: 0.3)))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .overlay {
                    VStack {
                        Text(timer.durationType)
                            .font(.system(size: customSize(geometry: geometry, factor: 0.10)))
                            .foregroundColor(timer.timerColor)
                        Spacer()
                            .frame(height: customSize(geometry: geometry, factor: 0.3) + 50)
                    }
                    
                }
                .overlay {
                    VStack {
                        Spacer()
                            .frame(height: customSize(geometry: geometry, factor: 0.3) + 70)
                        TimeTextRow(title: "Time Left:", time: timer.timeLeft)
                        TimeTextRow(title: "Total Time:", time: timer.totalTime)
                    }
                    // Reduce width if screen sixe is small
                    .frame(width: timer.totalTime.count > 5 ? 135 : 150)
                }
        }
    }
    
    /// Returns a custom fond size based on the given geometry and factor. The factor specifies the font size relative to the minimum
    /// value between the geometry width and height.
    /// - Parameters:
    ///   - geometry: The GeometryProxy for the current view
    ///   - factor: The factor by which to size the font. A value of 0.05 is a good starting point.
    private func customSize(geometry: GeometryProxy, factor: Double) -> Double {
        if geometry.size.height > geometry.size.width {
            return geometry.size.width * factor
        }
        
        return geometry.size.height * factor
    }
}

struct TimerTextView_Previews: PreviewProvider {
    static var previews: some View {
        let gripsArray = GripsArray(grip: GripViewModel())
        let timer = CountdownTimer(gripsArray: gripsArray)
        
        TimerTextView(timer: timer)
    }
}
