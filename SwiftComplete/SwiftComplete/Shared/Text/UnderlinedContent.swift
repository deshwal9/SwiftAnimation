//
//  UnderlinedContent.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

struct UnderlinedContent<Content>: View where Content: View {
    
    let content: Content?
    let color: Color
    let action: SimpleAction?
    
    init(action: SimpleAction? = nil,
         color: Color = .white,
         @ViewBuilder content: () -> Content? = { nil }) {
        self.action = action
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        Group {
            if let action = action {
                Button(action: action) {
                    contentView
                }
            } else {
                contentView
            }
        }
        .foregroundColor(color)
    }
    
    private var contentView: some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .offset(y: 3),
                alignment: .bottom
            )
            .padding(.bottom, 3)
    }
}
