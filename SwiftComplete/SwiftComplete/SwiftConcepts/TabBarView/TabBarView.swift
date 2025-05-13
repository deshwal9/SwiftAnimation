//
//  TabBarView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 12/12/24.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var vm: TabBarVM
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        CustomTabBarView()
    }
    @ViewBuilder
   func CustomTabBarView() -> some View {
       ScrollView(.horizontal){
           HStack(spacing: 20) {
               ForEach(vm.tabItems){ tab in
                   Button(action: { }) {
                       Text(tab.id.displayName)
                           .padding(.vertical, 12)
                           .foregroundStyle(Color.primary)
                           .contentShape(.rect)
                   }
                   .buttonStyle( .plain)
               }
           }
       }
    }
}

#Preview {
    TabBarView(vm: TabBarVM())
}
