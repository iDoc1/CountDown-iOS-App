//
//  DataController.swift
//  CountDown
//
//  Created by Ian Docherty on 9/9/23.
//

import CoreData
import Foundation

/// Loads and saves data to Core Data. Copied from the following source: 
/// https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CountDown")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
