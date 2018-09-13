//
//  PersistanceInstance.swift
//  Core Data
//
//  Created by MacBook Prp on 10/09/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//

import UIKit
import CoreData
final class PersistanceInstance {
    
    init() {}
    static var shared = PersistanceInstance()
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Core_Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func retriveMessage<T:NSManagedObject>(_ objecttype:T.Type)->[T]{
        
        let entity = String(describing: objecttype)
        let fetchresult = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let data = try context.fetch(fetchresult) as? [T]
            return data ?? [T]()
        }catch {
            print("error in retrive ")
            return [T]()
        }

    }
    
    func deleteObj(object:NSManagedObject){
        context.delete(object)
        save()
        
    }
    
    
    
    

    
}
