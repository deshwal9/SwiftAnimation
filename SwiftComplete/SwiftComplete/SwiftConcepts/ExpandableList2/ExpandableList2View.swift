//
//  ExpandableList2View.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 13/12/24.
//

import SwiftUI

struct ExpandableList2View: View {
    @ObservedObject var vm: ExpandableList2VM
    var body: some View {
        ScrollView{
            ForEach(vm.data) { item in
                ContentCell(item: item, expedable: vm.selectedcell.contains(item))
                    .modifier(ScrollCell())
                    .onTapGesture {
                        if vm.selectedcell.contains(item) {
                            vm.selectedcell.remove(item)
                        }else{
                            vm.selectedcell.insert(item)
                        }
                    }.animation(.easeIn(duration: 0.3))
                     .padding(.vertical, 2)
                   
            }
        }
    }
}
struct ContentCell:View {
    let item: listItem
    var expedable: Bool
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Text(item.title)
                        .font(.headline)
                        .padding(.leading, 10)
                    Spacer()
                    Image(systemName: "plus")
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .rotationEffect(.degrees(expedable ? 45 : 0))
                        .animation(.easeOut(duration: 0.3), value: expedable)
                        
                    
//                        .onTapGesture {
//                            withAnimation(.easeInOut(duration: 1)) {
//                                expedable.toggle() // change
//                            }
//                        }
                }
                if expedable{
                    VStack(alignment: .leading) {
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.leading, 100)
                            .padding(.top, 5)
                    }
                }
            }
            Spacer()
        }.contentShape(Rectangle())
    }
}

struct ScrollCell:ViewModifier {
    func body(content: Content) -> some View {
        Group{
            content
            Divider()
        }
    }
}

#Preview {
    ExpandableList2View(vm: ExpandableList2VM())
}
