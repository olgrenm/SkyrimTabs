//
//  CategoryView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI

struct CategoryView: View {
    let category: String
    
    var body: some View {
        switch category {
        case "quest":
            return Image(systemName: "crown")
        case "location":
            return Image(systemName: "map")
        case "warmth":
            return Image(systemName: "flame")
        case "ingredient":
            return Image(systemName: "leaf")
        case "enchantment":
            return Image(systemName: "bolt")
        case "gear":
            return Image(systemName: "wrench.and.screwdriver")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "quest")
    }
}
