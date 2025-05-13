//
//  ContentView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 06/11/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    enum Components: String, CaseIterable, Identifiable {
        var id : String { UUID().uuidString }
        case list
        case concourrencyModel
        case textfieldMenu
        case customSlider
        case expandableCollapsableList
        case expandableCollapsableList2
        case tabBarview
        case expertVoiceAnimation
        case speedWaveMeter
        case sequentialListLoading
        case buttonFocus
        var displayName: String{
            switch self {
            case .list:
                return "List"
            case .concourrencyModel:
                return "Concurrency Model"
            case .textfieldMenu:
                return "Textfield Menu"
            case .customSlider:
                return "CustomSlider"
            case .expandableCollapsableList:
                return "Expandable List"
            case .tabBarview:
                return "Tab bar view"
            case .expandableCollapsableList2:
                return "Expandable List 2"
            case .speedWaveMeter:
                return "speed Wave Meter"
            case .expertVoiceAnimation:
                return "Expert Voice Animation"
            case .sequentialListLoading:
                return "sequentialListLoading"
            case .buttonFocus:
              return "Button Focus"
            }
        }
    }
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var component: Components?
    @State private var selectedComponent: Components? = nil

    var body: some View {
        NavigationSplitView {
            List(Components.allCases, selection: $selectedComponent) { item in
                NavigationLink(value: item){
                  Text(item.displayName)
                }
            }
            .navigationTitle("Custom Components")
        } detail:{
            NavigationStack {
                switch selectedComponent {
                case .list:
                    ListVM().view
                case .concourrencyModel:
                    ConcurrencyModel().view
                case .textfieldMenu:
                   TextFieldMenuVM().view
                case .customSlider:
                    CustomSliderVM().view
                case .expandableCollapsableList:
                    ExpandableListVM().view
                case .tabBarview:
                    TabBarVM().view
                case .expandableCollapsableList2:
                    ExpandableList2VM().view
                case .speedWaveMeter:
                    SpeedWaveVM().view
                case .expertVoiceAnimation:
                    ExpertVoiceVM().view
                case .sequentialListLoading:
                    SequentialListLoadingVM().view
                case .buttonFocus:
                     ButtonFocusModel().view
                default:
                    Text("Unknown")
                }
            }
        }
        
        /*
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        */
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
