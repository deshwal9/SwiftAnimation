//
//  ConcurrencyView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 06/11/24.
//

import SwiftUI

struct ConcurrencyView: View {
    @ObservedObject var vm: ConcurrencyModel
    @State var isActive: Bool = true
    var body: some View {
        CustomView{
            Button("Hello button") {
                    print("hi")
                }
            VStack{
                Text("SwiftUI").dropShadow()
            }
        }
        buildDynamicView(condition: isActive)

        
        //        Group {
        //            Text("SwiftUI")
        //            Text("Combine")
        //            Text("Swift System")
        //        }
        //        .font(.headline)
    }
    @ViewBuilder
    func buildDynamicView(condition: Bool) -> some View {
        if condition {
            Text("This view is displayed")
        } else {
            Text("This view is hidden")
        }
    }
    
}


// due to this we are not able to assign alignment
//struct VStack<Content: View>: View {
//    let content: () -> Content
//
//    init(@ViewBuilder content: @escaping () -> Content) {
//        self.content = content
//    }
//
//    var body: some View {
//        // Create and arrange the subviews in a vertical stack.
//        content()
//    }
//}


#Preview {
    ConcurrencyView(vm: ConcurrencyModel())
}
