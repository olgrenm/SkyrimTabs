//
//  QuestView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI

struct QuestView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var addViewShown = false
    let viewModel = ListViewModel()
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Item.isComplete, order: .forward),
            SortDescriptor(\Item.name, order: .forward)
        ],
        //predicate: NSPredicate(format: "category == %@", "quest"),
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var searchTerm = ""
    var searchQuery: Binding<String> {
        Binding {
            searchTerm
        } set: { newValue in
            searchTerm = newValue
            
            guard !newValue.isEmpty else {
                items.nsPredicate = nil
                return
            }
            
            items.nsPredicate = NSPredicate(
                format: "name contains[cd] %@",
            newValue)
        }
    }
    enum FilterType {
        case quest, warmth, ingredient, enchantment, gear
    }
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredItems) { item in
                    NavigationLink {
                        AddItemView(itemId: item.objectID)
                    } label: {
                        ItemView(item: item)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(
                        for: indexSet,
                           section: items,
                           viewContext: viewContext)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddItemView()
            }
            .navigationTitle(title)
            .searchable(text: searchQuery)
        }
    }
    
    var title: String {
        switch filter {
        case .quest:
            return "Quests"
        case .warmth:
            return "Warmth"
        case .ingredient:
            return "Ingredients"
        case .enchantment:
            return "Enchantments"
        case .gear:
            return "Gear"
        }
    }
    
    var filteredItems: [Item] {
        switch filter {
        case .quest:
            return items.filter { $0.category == "quest" }
        case .warmth:
            return items.filter { $0.category == "warmth" }
        case .ingredient:
            return items.filter { $0.category == "ingredient" }
        case .enchantment:
            return items.filter { $0.category == "enchantment" }
        case .gear:
            return items.filter { $0.category == "gear" }
        }
    }
}

struct QuestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestView(filter: .quest)
    }
}
