//
//  Item.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI
import CoreData

@objc(Item)

public class Item: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var name: String
    @NSManaged public var category: String
    @NSManaged public var desc: String
    @NSManaged public var isComplete: Bool
    @NSManaged public var questType: String
    @NSManaged public var hasMapMarker: Bool
    @NSManaged public var loot: String
    @NSManaged public var locationType: String
    @NSManaged public var head: Int16
    @NSManaged public var torso: Int16
    @NSManaged public var hands: Int16
    @NSManaged public var feet: Int16
    @NSManaged public var effect1: String
    @NSManaged public var effect2: String
    @NSManaged public var effect3: String
    @NSManaged public var effect4: String
    @NSManaged public var canPlant: Bool
}

extension Item: Identifiable {}
