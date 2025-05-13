//
//  NilableView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

// Display actual content if not empty
// Otherwise placeholder text view with default as N/A text.
struct NilableView<Content>: View where Content: View {
    let isEmpty: Bool
    let placeholderText: String
    let textColor: Color
    let content: () -> Content
    
    init(
        isEmpty: Bool = false,
        placeholderText: String = "",
        textColor: Color = .black,
        content: @escaping () -> Content
    ) {
        self.isEmpty = isEmpty
        self.placeholderText = placeholderText
        self.textColor = textColor
        self.content = content
    }
    
    var body: some View {
        VStack {
            if isEmpty {
                PlaceholderTextView(
                    text: placeholderText,
                    textColor: textColor
                )
            } else {
                self.content()
            }
        }
    }
}

// Placholder text for empty view.
// defaults to N/A
struct PlaceholderTextView: View {
    var text: String = ""
    let textColor: Color
    
    init(
        text: String = "",
        textColor: Color = .red
    ) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
