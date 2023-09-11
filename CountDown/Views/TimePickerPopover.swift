//
//  TimerPickerPopover.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI
import Popovers

/// A button with a title that, when pressed, displays a popover view allowing the user to choose a number of minutes and seconds.
struct TimePickerPopover: View {
    @Binding var minute: Int
    @Binding var second: Int
    let title: String
    @State private var showPopover = false
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button("\(minute)min \(second)sec") {
                showPopover = true
            }
            .frame(width: 125.0, height: 32.0)
            .background(Color(.systemGray6))
            .cornerRadius(8.0)
            .foregroundColor(.black)
        }
        .popover(
            present: $showPopover,
            attributes: {
                $0.position = .absolute(originAnchor: .top, popoverAnchor: .bottomLeft)
                $0.rubberBandingMode = .none
            }) {
                TimePicker(
                    minute: $minute,
                    second: $second)
                .frame(width: 250.0, height: 175.0)
                .background(.white)
                .cornerRadius(16.0)
                .shadow(color: .gray.opacity(15.0), radius: 5, x: 1, y: -1)
            }
    }
}

struct TimerPickerPopover_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerPopover(minute: .constant(20), second: .constant(12), title: "Break")
    }
}
