//
//  TimerButton.swift
//  CountDown
//
//  Created by Ian Docherty on 9/16/23.
//

import SwiftUI

/// A standard timer button with a given action
struct TimerButton: View {
    let action : @MainActor () -> ()
    let title: String
    let systemImage: String
    let color: Color
    /// When true the icon is shown to the left of the title instead of the right
    var iconOnLeading = false

    var body: some View {
        Button(action: action) {
            Group {
                if iconOnLeading {
                    Label(title, systemImage: systemImage)
                        .labelStyle(.titleAndIcon)
                } else {
                    Label(title, systemImage: systemImage)
                        .labelStyle(.trailingIcon)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(color)
    }
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(
            action: {},
            title: "Start",
            systemImage: "play.fill",
            color: Theme.lightBlue.mainColor)
    }
}
