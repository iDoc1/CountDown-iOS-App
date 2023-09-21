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

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .frame(maxWidth: .infinity)
                .labelStyle(.trailingIcon)
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
