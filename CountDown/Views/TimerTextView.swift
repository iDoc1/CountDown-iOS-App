//
//  TimerTextView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// Text that displays the current time left in the countdown in format "mm:ss"
struct TimerTextView: View {
    let timerString: String

    var body: some View {
        GeometryReader { geometry in
            Text(timerString)
                .font(.system(size: geometry.size.height > geometry.size.width
                              ? geometry.size.width * 0.3
                              : geometry.size.height * 0.3))
        }
    }
}

struct TimerTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTextView(timerString: "0:12")
    }
}
