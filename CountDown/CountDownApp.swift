//
//  CountDownApp.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import SwiftUI

@main
struct CountDownApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
