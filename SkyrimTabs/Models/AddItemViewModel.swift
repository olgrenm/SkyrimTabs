//
//  ItemViewModel.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import CoreData
import Foundation

struct AddItemViewModel {
    func fetchItem(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> Item? {
        guard let item = context.object(with: objectId) as? Item else {
            return nil
        }
        
        return item
    }
    
    func saveItem(
        itemId: NSManagedObjectID?,
        with itemValues: ItemValues,
        in context: NSManagedObjectContext
    ){
        let item: Item
        if let objectId = itemId,
           let fetchedItem = fetchItem(for: objectId, context: context) {
            item = fetchedItem
        } else {
            item = Item(context: context)
        }
        
        item.name = itemValues.name
        item.category = itemValues.category
        item.isComplete = itemValues.isComplete
        item.desc = itemValues.desc
        item.questType = itemValues.questType
        item.hasMapMarker = itemValues.hasMapMarker
        item.loot = itemValues.loot
        item.locationType = itemValues.locationType
        item.head = itemValues.head
        item.torso = itemValues.torso
        item.hands = itemValues.hands
        item.feet = itemValues.feet
        item.effect1 = itemValues.effect1
        item.effect2 = itemValues.effect2
        item.effect3 = itemValues.effect3
        item.effect4 = itemValues.effect4
        item.canPlant = itemValues.canPlant
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
