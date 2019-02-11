//
//  CoreDataStack.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 11/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let sharedInstance = CoreDataStack()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolve error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataStack {
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
