//
//  BreakDurationPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 12/19/23.
//

import SwiftUI

/// A picker for specifying the break duration
struct BreakDurationPicker: View {
    @Binding var breakMinutes: Int
    @Binding var breakSeconds: Int
    @Binding var showBreakPicker: Bool
    var title: String
    
    var body: some View {
        TimePickerButton(
            minute: $breakMinutes,
            second: $breakSeconds,
            showPicker: $showBreakPicker,
            title: title)
        if showBreakPicker {
            TimePicker(
                minute: $breakMinutes,
                second: $breakSeconds,
                height: 125.0)
        }
    }
}

struct BreakDurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        BreakDurationPicker(
            breakMinutes: .constant(1),
            breakSeconds: .constant(35),
            showBreakPicker: .constant(true),
            title: "Break")
    }
}
