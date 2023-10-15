//
//  CountDownApp.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

@main
struct CountDownApp: App {
    @AppStorage("isDarkMode") private var darkModeOn = true
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .preferredColorScheme(darkModeOn ? .dark : .light)
        }
    }
}
