//
//  ContentView.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

/// The main view for the app that contains with a bottom TabView navigation bar
struct MainView: View {
    var body: some View {
        TabView {
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.climbing")
                }
            TimerSetupView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            // Ensures the TabView top divider is visible
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
