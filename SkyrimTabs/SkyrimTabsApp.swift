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
                QuestView()
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Quests", systemImage: "crown")
                    }
                IngredientView()
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Ingredients", systemImage: "leaf")
                    }
                EnchantmentView()
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Enchantments", systemImage: "bolt")
                    }
                WarmthView()
                    .environment(\.managedObjectContext, PersistenceManager.shared.persistentContainer.viewContext)
                    .tabItem {
                        Label("Warmth", systemImage: "flame")
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
