//
//  CustomView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 07/11/24.
//

import SwiftUI

struct CustomView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
    }
}

#Preview {
    CustomView(content: { Text("Hello, World!") })
}


struct WrapperView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .center) {
            content()
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}
