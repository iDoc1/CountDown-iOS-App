//
//  CountDownApp.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

@main
struct CountDownApp: App {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("isDarkMode") private var darkModeOn = true
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(darkModeOn ? .dark : .light)
        }
        .onChange(of: scenePhase) { _ in
            // Save any changes if app enters the background
            persistenceController.save()
        }
    }
}
