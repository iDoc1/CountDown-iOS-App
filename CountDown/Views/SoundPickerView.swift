//
//  SoundPickerView.swift
//  CountDown
//
//  Created by Ian Docherty on 10/9/23.
//

import SwiftUI

/// Allows user to pick a timer sound from a list of available sounds
struct SoundPickerView: View {
    @Environment(\.colorScheme) private var colorScheme
    let soundTypes = TimerSound.allCases.map { $0 }
    @Binding var selectedSound: TimerSound

    var body: some View {
        List {
            Section {
                ForEach(0..<soundTypes.count, id: \.self) { index in
                    HStack {
                        Button(action: { selectedSound = soundTypes[index] }) {
                            HStack {
                                Text(soundTypes[index].displayName)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                Spacer()
                                
                                if selectedSound == soundTypes[index] {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Sound Type")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SoundPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPickerView(selectedSound: .constant(.beep))
    }
}
