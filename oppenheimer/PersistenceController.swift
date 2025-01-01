//
//  PersistenceController.swift
//  oppenheimer
//
//  Created by Chris Kim on 12/29/24.
//

// Core Data -->

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) { // inMemory = useful for testing purposes
        // The NSPersistentContainer manages the Core Data stack, including loading the .xcdatamodeld file.
        container = NSPersistentContainer(name: "WorkoutModel") // .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in // loadpersistentstores = loads the database from disk. 
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
