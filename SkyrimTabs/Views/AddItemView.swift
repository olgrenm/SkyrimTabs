//
//  AddItemView.swift
//  SkyrimTabs
//
//  Created by Michael Olgren on 2/24/22.
//

import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var name = ""
    @State private var nameError = false
    @State private var category = ""
    @State private var categories = ["enchantment", "gear", "ingredient", "quest", "warmth"]
    @State private var isComplete = false
    @State private var desc = ""
    @State private var questType = ""
    @State private var questTypes = ["main", "side", "misc", "non"]
    @State private var hasMapMarker = false
    @State private var loot = ""
    @State private var locationType = ""
    @State private var locationTypes = ["Camp", "Cave", "Daedric", "Docks", "Dragon lair", "Dwarven", "Farm", "Farm/mill", "Fort", "Giant", "Grove", "Imp Army", "Lthouse", "Lumber", "Mine", "Mtn Pass", "Orc hold", "Pt/Interest", "Pond", "Ruins", "Settlement", "Shack", "Shipwreck", "Stable", "Standing St", "Stclk Army", "Town", "Mine", "Tomb", "Tower", "Watch Tower", "NEED TO ADD"]
    @State private var head = ""
    @State private var torso = ""
    @State private var hands = ""
    @State private var feet = ""
    @State private var effect1 = ""
    @State private var effect2 = ""
    @State private var effect3 = ""
    @State private var effect4 = ""
    @State private var effects = ["unknown", "cure dis", "dmg health", "dmg mag", "dmg mag reg", "dmg stam", "dmg stam reg", "fear", "fort alchem", "fort alter", "fort barter", "fort block", "fort carry wt", "fort conj", "fort destr", "fort ench", "fort health", "fort heavy", "fort illus", "fort lt arm", "fort lockpic", "fort mag", "fort marks", "fort 1H", "fort pickpoc", "fort restor", "fort smith", "fort stam", "fort sneak", "fort 2H", "frenzy", "invis", "ling dmg health", "ling dmg mag", "ling dmg stam", "paralysis", "rav health", "rav mag", "rav stam", "reg health", "reg mag", "reg stam", "res fire", "res frost", "res magic", "res poison", "res shock", "rest health", "rest mag", "rest stam", "slow", "waterbreath", "weak to fire", "weak to frost", "weak to magic", "weak to magic", "weak to poison", "weak to shock", "MUST ADD"]
    @State private var canPlant = false
    @State private var input = ""
    
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    var itemId: NSManagedObjectID?
    let viewModel = AddItemViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            TextField("Name", text: $name, prompt: Text("Name"))
                                .focused($focusedField, equals: .field)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                        self.focusedField = .field
                                    }
                                }
                                .disableAutocorrection(true)
                                .font(.title)
                            if nameError {
                                Text("Name is required")
                                    .foregroundColor(.red)
                            }
                        }
                        Group {
                            Section {
                                VStack {
                                    Picker("Category", selection: $category) {
                                        ForEach(categories, id:\.self) {
                                            Text($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                    Toggle("Done?", isOn: $isComplete)
                                    HStack {
                                        Text("Description")
                                            .font(.caption)
                                        Spacer()
                                    }
                                    TextEditor(text: $desc)
                                        .padding()
                                        .border(.secondary)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                }
                            }  //end section
                            if category == "quest" {
                                Section("Quest type") {
                                    Picker("Quest type:", selection: $questType) {
                                        ForEach(questTypes, id:\.self) {
                                            Text($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                    Toggle("Map marker?", isOn: $hasMapMarker)
                                    TextField("Loot", text: $loot)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                        .padding()
                                        .border(.secondary)
                                    Picker("Location type:", selection: $locationType) {
                                        ForEach(locationTypes, id:\.self) {
                                            Text($0)
                                        }
                                    }
                                }
                            } //end if
                        }  //end group
                        if category == "ingredient" {
                            Group {
                                Section {
                                    Picker("Effect 1:", selection: $effect1) {
                                        ForEach(effects, id:\.self) {
                                            Text($0)
                                        }
                                    }
                                }
                                Section {
                                    Picker("Effect 2:", selection: $effect2) {
                                        ForEach(effects, id:\.self) {
                                            Text($0)
                                        }
                                    }
                                }
                                Section {
                                    Picker("Effect 3:", selection: $effect3) {
                                        ForEach(effects, id:\.self) {
                                            Text($0)
                                        }
                                    }
                                }
                                Section {
                                    VStack {
                                        Picker("Effect 4:", selection: $effect4) {
                                            ForEach(effects, id:\.self) {
                                                Text($0)
                                            }
                                        }
                                    } // end VStack
                                    Toggle("Can plant?", isOn: $canPlant)
                                } // end Section
                            }  // end Group
                        } // end if
                        if category == "warmth" {
                            Group {
                                Section("Warmth:") {
                                    VStack {
                                        HStack {
                                            Image(systemName: "person")
                                            TextField("", text: $head)
                                                .keyboardType(.decimalPad)
                                            Image(systemName: "tshirt")
                                            TextField("", text: $torso)
                                                .keyboardType(.decimalPad)
                                        }
                                        HStack {
                                            Image(systemName: "hand.raised")
                                            TextField("", text: $hands)
                                                .keyboardType(.decimalPad)
                                            Image(systemName: "figure.walk")
                                            TextField("", text: $feet)
                                                .keyboardType(.decimalPad)
                                        }
                                    }
                                }
                            }
                        } // end if
                    } // Section after Form
                }  // end form
                Button {
                    if name.isEmpty {
                        nameError = name.isEmpty
                    } else {
                        let values = ItemValues(
                            name: name,
                            category: category,
                            isComplete: isComplete,
                            desc: desc,
                            questType: questType,
                            hasMapMarker: hasMapMarker,
                            loot: loot,
                            locationType: locationType,
                            head: Int16(head) ?? 0,
                            torso: Int16(torso) ?? 0,
                            hands: Int16(hands) ?? 0,
                            feet: Int16(feet) ?? 0,
                            effect1: effect1,
                            effect2: effect2,
                            effect3: effect3,
                            effect4: effect4,
                            canPlant: canPlant)
                        
                        viewModel.saveItem(itemId: itemId, with: values, in: viewContext)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 300)
                }   // end button
                .tint(Color(.blue))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .controlSize(.large)
            } // end vstack
            .navigationTitle("\(itemId == nil ? "Add item" : "Edit item")")
            Spacer()
        }  // end nav view
        .onAppear {
            guard
                let objectId = itemId,
                let item = viewModel.fetchItem(for: objectId, context: viewContext)
            else {
                return
            }
            
            name = item.name
            category = item.category
            isComplete = item.isComplete
            desc = item.desc
            questType = item.questType
            hasMapMarker = item.hasMapMarker
            loot = item.loot
            locationType = item.locationType
            head = String(item.head)
            torso = String(item.torso)
            hands = String(item.hands)
            feet = String(item.feet)
            effect1 = item.effect1
            effect2 = item.effect2
            effect3 = item.effect3
            effect4 = item.effect4
            canPlant = item.canPlant
        } // end onAppear
    }  // end body View
}  // end struct

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
