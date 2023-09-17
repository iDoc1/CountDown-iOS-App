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
    @Environment(\.colorScheme) private var colorScheme
    @Binding var minute: Int
    @Binding var second: Int
    let title: String
    @State private var showPopover = false
    
    /// Returns the font color corresponding to the current state of light/dark mode
    /// - Returns: A Color that is either black or white
    private func fontColor() -> Color {
        colorScheme == .dark ? .white : .black
    }
    
    var body: some View {
        WindowReader { window in
            HStack {
                Text(title)
                Spacer()
                Button(action: { showPopover = !showPopover }) {
                    Text("\(minute)min \(second)sec")
                        .foregroundColor(showPopover ? .blue : fontColor())
                }
                .frame(width: 125.0, height: 32.0)
                .background(colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
                .cornerRadius(8.0)
                .buttonStyle(PlainButtonStyle())
                .frameTag("timeTextButton")
            }
            .popover(
                present: $showPopover,
                attributes: {
                    $0.position = .absolute(originAnchor: .topRight, popoverAnchor: .bottomLeft)
                    $0.rubberBandingMode = .none
                    // Prevents popover from immediately reopening if button pressed while open
                    $0.dismissal.excludedFrames = {[window.frameTagged("timeTextButton")]}
                }) {
                    TimePicker(minute: $minute, second: $second)
                        .frame(width: 250.0, height: 175.0)
                        .background(colorScheme == .dark ? .black : Color(UIColor.systemGray6))
                        .cornerRadius(16.0)
                        .shadow(color: Color(.systemGray2), radius: 30, x: 0, y: 0)
                }
        }
    }
}

struct TimerPickerPopover_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerPopover(minute: .constant(20), second: .constant(12), title: "Break")
    }
}
