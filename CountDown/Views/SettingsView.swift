//
//  SettingsView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// Shows a list of settings related to timer sound, vibration, and app apprearance
struct SettingsView: View {
    @AppStorage("timerSound") private var timerSoundOn = true
    @AppStorage("soundType") private var soundType: TimerSound = .strings
    @AppStorage("timerVibration") private var timerVibrationOn = false
    @AppStorage("isDarkMode") private var darkModeOn = true
    /// This is utilized to provide an animation to the Sound Type row. AppStorage does not allow animations on change of value.
    @State private var showSoundType = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle(isOn: $timerSoundOn.animation(), label: {
                        Label("Sound", systemImage: "speaker.wave.2")
                    })
                    .onChange(of: timerSoundOn) { newValue in
                        withAnimation { showSoundType = newValue }
                    }
                    
                    if showSoundType {
                        NavigationLink(destination: SoundPickerView(selectedSound: $soundType)) {
                            HStack {
                                Text("Sound Type")
                                Spacer()
                                Text(soundType.displayName)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Toggle(isOn: $timerVibrationOn) {
                        Label("Vibration Only", systemImage: "dot.radiowaves.left.and.right")
                    }
                } header: {
                    Text("Timer Feedback")
                } footer: {
                    Text("Silent mode must be disabled for sound to function")
                }
                
                Section {
                    Toggle(isOn: $darkModeOn) {
                        Label("Dark Mode", systemImage: "moon")
                    }
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Enabling dark mode reduces power consumption and improves battery life while the timer is running")
                }
            }
            .onAppear {
                showSoundType = timerSoundOn
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
