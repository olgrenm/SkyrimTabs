//
//  IngredientView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/25/22.
//

import SwiftUI

struct IngredientView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var addViewShown = false
    let viewModel = ListViewModel()
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Item.isComplete, order: .forward),
            SortDescriptor(\Item.name, order: .forward)
        ],
        predicate: NSPredicate(format: "category == %@", "ingredient"),
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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
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
            .navigationTitle("Ingredients")
            .searchable(text: searchQuery)
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}
