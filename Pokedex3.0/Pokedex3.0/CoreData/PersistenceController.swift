//
//  PersistenceController.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import CoreData

// kinda like a helper
struct PersistenceController {
    
    // Singleton
    static let shared = PersistenceController()

    // create container
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Stash")
        // load the persistenceStores
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // functions to make the PersistenceController accessible
    // complete with error if error occurs and
    // complete with nil if everything is successful
    func save(completion: @escaping (Error?) -> () = { _ in }) {
        let context = container.viewContext
        // make sure that we only save when change occurs
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = { _ in }) {
        let context = container.viewContext
        context.delete(object)
        // after delete we need to save again
        save(completion: completion)
    }
}
