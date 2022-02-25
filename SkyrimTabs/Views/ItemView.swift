//
//  ItemView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text(item.isComplete ? Image(systemName: "checkmark.square") : Image(systemName: "square"))
                        .font(.title)
                    if (item.category == "quest" || item.category == "location") {
                        Text(item.hasMapMarker ? Image(systemName: "mappin.and.ellipse") : Image(systemName: "mappin.slash"))
                            .font(.title)
                    }
                    if item.category == "ingredient" {
                        Text(item.canPlant ? Image(systemName: "leaf") : Image(systemName: "mappin.slash"))
                            .font(.title)
                    }
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title)
                    Text(item.desc)
                    if (item.category == "quest" || item.category == "location") {
                        Text(item.loot)
                    }
                }
            }
            if item.category == "warmth" {
                VStack {
                    HStack {
                        Image(systemName: "person")
                        Text(String(item.head))
                        Spacer(minLength: 10)
                        Image(systemName: "tshirt")
                        Text(String(item.torso))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "hand.raised")
                        Text(String(item.hands))
                        Spacer(minLength: 10)
                        Image(systemName: "figure.walk")
                        Text(String(item.feet))
                    }
                }
                .font(.title)
            }
            if item.category == "ingredient" {
                VStack {
                    HStack {
                        Text(String(item.effect1))
                        Spacer(minLength: 10)
                        Text(String(item.effect2))
                    }
                    Spacer()
                    HStack {
                        Text(String(item.effect3))
                        Spacer(minLength: 10)
                        Text(String(item.effect4))
                    }
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: getItem())
    }
    
    static func getItem() -> Item {
        let item = Item(context: PersistenceManager(inMemory: true).persistentContainer.viewContext)
        item.name = "Test"
        item.category = "quest"
        item.desc = "Test desc"
        item.hasMapMarker = false
        item.loot = "Test loot"
        return item
    }
}
