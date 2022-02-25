//
//  PersistenceManager.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//
import CoreData
import SwiftUI

struct PersistenceManager {
    static let shared = PersistenceManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Stash")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
    
    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for itemNumber in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.name = "Item \(itemNumber)"
            newItem.category = "quest"
            newItem.isComplete = false
            newItem.desc = "desc"
            newItem.questType = "quest type"
            newItem.hasMapMarker = true
            newItem.loot = "loot"
            newItem.locationType = "ruins"
            newItem.head = 2
            newItem.torso = 2
            newItem.hands = 2
            newItem.feet = 2
            newItem.effect1 = "effect1"
            newItem.effect2 = "effect2"
            newItem.effect3 = "effect3"
            newItem.effect4 = "effect4"
            newItem.canPlant = true
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
