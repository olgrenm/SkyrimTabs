//
//  SkyrimTabsApp.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI

@main
struct SkyrimTabsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                QuestView(filter: .quest)
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Quests", systemImage: "crown")
                    }
                QuestView(filter: .ingredient)
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Ingredients", systemImage: "leaf")
                    }
                QuestView(filter: .enchantment)
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Enchantments", systemImage: "bolt")
                    }
                QuestView(filter: .warmth)
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Warmth", systemImage: "flame")
                    }
                QuestView(filter: .gear)
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Gear", systemImage: "wrench.and.screwdriver")
                    }
                InfoView()
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Info", systemImage: "questionmark.circle")
                    }
            }
        }
    }
}
