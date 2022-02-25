//
//  InfoView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/23/22.
//

import SwiftUI

struct InfoView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Text("This is where the app info will go")
            }
            .navigationTitle("App Info")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
