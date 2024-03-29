//
//  Persistence.swift
//  FlockPocket
//
//  Created by snow on 12/5/23.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init?(inMemory: Bool = false) {
        let storageName = "FlockPocket"
        container = NSPersistentContainer(name: storageName)
        
        // 1
        guard let storeLocation = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.net.snowskeleton.FlockPocket")?
            .appendingPathComponent("\(storageName).sqlite") else {
            return nil
        }
        // 2
        let description = NSPersistentStoreDescription(url: storeLocation)
        // 3
        container.persistentStoreDescriptions = [description]
        
// uncomment this to wipe the coredata container on next launch
//        do {
//            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
//            print("Success")
//        } catch {
//            
//            print(error.localizedDescription)
//            print("Fail")
//        }
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
