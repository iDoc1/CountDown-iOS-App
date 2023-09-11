//
//  TimerPicker.swift
//  CountDown
//
//  Created by Ian Docherty on 9/10/23.
//

import SwiftUI

/// A pair of wheel pickers to select the given minute and second bindings. Adapted from the following source:
/// https://stackoverflow.com/questions/66601955/is-there-support-for-something-like-timepicker-hours-mins-secs-in-swiftui
struct TimePicker: View {
    @Binding var minute: Int
    @Binding var second: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Minutes picker
                SinglePicker(
                    timeValue: $minute,
                    unitOfTime: "min",
                    geometry: geometry,
                    minValue: 0,
                    maxValue: 59)
                
                // Seconds picker
                SinglePicker(
                    timeValue: $second,
                    unitOfTime: "sec",
                    geometry: geometry,
                    minValue: 0,
                    maxValue: 59)
            }
        }
    }
}

/// A single picker for a particular unit of time
private struct SinglePicker: View {
    @Binding var timeValue: Int
    let unitOfTime: String
    let geometry: GeometryProxy
    let minValue: Int
    let maxValue: Int

    var body: some View {
        ZStack(alignment: Alignment.init(horizontal: .customCenter, vertical: .center)) {
            HStack {
                Text(verbatim: "59")
                    .foregroundColor(.clear)
                    .alignmentGuide(.customCenter) { $0[HorizontalAlignment.center] }
                Text(unitOfTime)
            }
            Picker(unitOfTime, selection: $timeValue) {
                ForEach(minValue..<maxValue, id:\.self) { val in
                    Text(verbatim: String(val)).tag(String(val))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: geometry.size.width / 2, height: geometry.size.height)
            .clipped()
        }
    }
}

private extension HorizontalAlignment {
    enum CustomCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let customCenter = Self(CustomCenter.self)
}

struct TimerPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(minute: .constant(20), second: .constant(12))
    }
}
