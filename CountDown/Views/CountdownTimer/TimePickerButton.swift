//
//  TimerPickerPopover.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI

/// A button with a title that, when pressed, changes the given showPicker variable
struct TimePickerButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var minute: Int
    @Binding var second: Int
    @Binding var showPicker: Bool
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: {
                withAnimation{showPicker = !showPicker}
                
            }) {
                Text("\(minute)min \(second)sec")
                    .foregroundColor(showPicker ? .blue : fontColor())
            }
            .frame(width: 125.0, height: 32.0)
            .background(colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
            .cornerRadius(8.0)
        }
    }
    
    /// Returns the font color corresponding to the current state of light/dark mode
    /// - Returns: A Color that is either black or white
    private func fontColor() -> Color {
        colorScheme == .dark ? .white : .black
    }
}

struct TimerPickerPopover_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerButton(
            minute: .constant(20),
            second: .constant(12),
            showPicker: .constant(true),
            title: "Break")
    }
}
