//
//  ListView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 08/11/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var vm: ListVM
    @State private var text:String = "Row view"
    @State var volume:CGFloat = 50.0
    @State private var message:String = ""
    @State private var list:[String] = ["ansmam", "ankit", "ankit1"]
    var body: some View {
        List{
            Text("Sample1")
            RowView(text: $text)
            DisclosureRow {
                Text("Sample1")
            }
            //MARK: Sample1: testing of tableview List row custome component
            
            DisclosureRowSamples()
                .frame(height: 300)
            
//            List(list, id: \.self ){ item in
//                Text(item)
//            }
            
            Label {
                Text("Disclosure Row")
            } icon: {
                Image(systemName: "arrow.2.circlepath.circle")
            }

              
        }
    }
    
    @ViewBuilder
    func DisclosureRowSamples() -> some View {
        VStack{
            List{
                // Discloser Row type custom view
                DisclosureRow {
                    Text("Row view")
                }
                DisclosureRow2(content: {
                    Text("Content")
                }){
                    Text("Extra Content")
                }
                
                
                DisclosureRow3(content: {
                    Text("Content")
                }){
                    Text("Extra Content")
                }
                
                DisclosureRow3(content: {
                    Text("Content with non extra")
                })
                
                DisclosureRow4(content: {
                    Text(" Title")
                }, extra: {
                    Text("body")
                }, onSelect: {
                    vm.onrowSelection()
                },
                showDisclosureIndicator: true,
                showInfoButton: false)
            }
        }
        .background(Color.gray.opacity(0.1)) // Background color for the entire List
        .cornerRadius(10) // Optional corner radius for the entire List
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    ListView(vm: ListVM())
}

struct RowView:View {
    @Binding var text:String
    var body: some View {
        Text("Sample row 1")
    }
}

@ViewBuilder
func dynamicView(isLoggedIn: Bool) -> some View {
    if isLoggedIn {
        Text("Welcome back!")
            .foregroundColor(.green)
    } else {
        Text("Please log in")
            .foregroundColor(.red)
    }
}
