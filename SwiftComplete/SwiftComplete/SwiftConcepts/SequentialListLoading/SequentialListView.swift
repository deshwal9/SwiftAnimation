//
//  SequentialListView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 26/12/24.
//

import SwiftUI

struct SequentialListView: View {
    @ObservedObject var vm: SequentialListLoadingVM
    var body: some View {
        VStack{
            SequentialListLoadingView(items: vm.items)
        }
    }
}

#Preview {
    SequentialListView(vm: SequentialListLoadingVM())
}

// SequentialListLoadingView is an annimation for Lasy Loading

struct SequentialListLoadingView: View {
    let items:[Int]?
    @State private var visibleItems: [Int] = [] // Tracks which items are visible

    var body: some View {
        List(items ?? [], id: \.self) { item in
            Text("Item \(item)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
                .opacity(visibleItems.contains(item) ? 1 : 0) // Only show if visible
                .animation(.easeInOut(duration: 0.5), value: visibleItems.contains(item)) // Smooth fade-in animation
        }
        .onAppear {
            loadItemsSequentially()
        }
    }
    
    func loadItemsSequentially() {
        if let array = items {
            for (index, item) in array.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                    visibleItems.append(item) // Add item to visible items
                }
            }
        }
    }
}
