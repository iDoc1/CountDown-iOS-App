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
    @Binding var selectedSound: TimerSound
    private let soundTypes = TimerSound.allCases.map { $0 }
    private let players = TimerSound.allCases.map { TimerSoundPlayer(type: $0) }
    
    var body: some View {
        List {
            Section {
                ForEach(0..<soundTypes.count, id: \.self) { index in
                    HStack {
                        Button(action: {
                            selectedSound = soundTypes[index]
                            playSoundAtIndex(index)
                        }) {
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
    
    /// Plays the sound corresponding to the given index in the players array
    /// - Parameter index: The index at which to play the sound
    private func playSoundAtIndex(_ index: Int) {
        players[index].playLowSound()
    }
}

struct SoundPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPickerView(selectedSound: .constant(.beep))
    }
}
