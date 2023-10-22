//
//  PersistenceController.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import Foundation
import CoreData

/// Controls the the persistence of Core Data models within the app. Additionally, provides a preview var that is used to display sample
/// data within app preview canvas.
///
/// Adapted from the following source:
/// https://www.hackingwithswift.com/quick-start/swiftui/how-to-configure-core-data-to-work-with-swiftui
struct PersistenceController {
    // A singleton for entire app to use
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        // Create 2 example workouts
        let workoutType1 = WorkoutType(context: controller.container.viewContext)
        workoutType1.name = "powerEndurance"
        let workoutType2 = WorkoutType(context: controller.container.viewContext)
        workoutType2.name = "maxStrength"
        
        let workout1 = Workout(context: controller.container.viewContext)
        workout1.id = UUID()
        workout1.name = "Repeaters"
        workout1.descriptionText = "RCTM Advanced Repeaters Protocol"
        workout1.createdDate = Date()
        workout1.workoutType = workoutType1
        
        let workout2 = Workout(context: controller.container.viewContext)
        workout2.id = UUID()
        workout2.name = "Max Hangs"
        workout2.descriptionText = "Max weight hangs on 20mm edge"
        workout2.createdDate = Date()
        workout2.lastUsedDate = Date()
        workout2.workoutType = workoutType2
        
        return controller
    }()
    
    // An initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CountDown")
        
        // Save inMemory data to /dev/null/ so sample data is not permanently saved
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Checks if context has changed then commits changes if needed
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
