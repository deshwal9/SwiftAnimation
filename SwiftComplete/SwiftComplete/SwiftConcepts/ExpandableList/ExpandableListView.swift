//
//  ExpandableListView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

struct ExpandableListView: View {
    @ObservedObject var vm: ExpandableListVM
    @State private var rotation: Double = 0
    @State private var isExpanded: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                List{
                    /*
                    DefaultExpandedView(title: "Sample Title", subTitle: "Sample Sub Title", icon: "informationCircle", action: {
                        print("Action tapped")
                    }, loader: $vm.loader) { item in
                        Text("Sample")
                    }
                     */
                    
                    ExpandCollapseView(expanded: $isExpanded, title: "Sample Title", loader: $vm.loader) { item in
                        NilableView(
                            isEmpty: false, placeholderText: "Sample 2222") {
                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            }
                    }
                    
                }
                
                .listStyle(.inset)
                .selectionDisabled()
                Spacer()
            }
            .navigationTitle("Expand Collapse view")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


#Preview {
    ExpandableListView(vm: ExpandableListVM())
}
