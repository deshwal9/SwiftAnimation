//
//  ViewModefier.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 07/11/24.
//

import SwiftUI
struct ShadowBorderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .border(Color.black, width: 1)
            .shadow(radius: 5)
    }
}

extension View {
    func dropShadow() -> some View {
        ModifiedContent(content: self, modifier: ShadowBorderModifier())
       // modifier(ShadowBorderModifier())
    }
}
