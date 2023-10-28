//
//  PersistentStorage.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 27/10/23.
//

import CoreData

final class PersistentStorage {
    
    static let shared = PersistentStorage()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
            let container = NSPersistentContainer(name: "PodTalk")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T] {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {
                return []
            }
            return result
        } catch {
            debugPrint(error)
        }
        return []
    }
}
