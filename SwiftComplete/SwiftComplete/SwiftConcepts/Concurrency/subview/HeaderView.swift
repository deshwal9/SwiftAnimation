//
//  HeaderView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 07/11/24.
//
import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)

            Text(subtitle)
                .font(.body)
        }
    }
}

#Preview {
    HeaderView(title: "SwiftComplete", subtitle: "A SwiftUI library for completing code")
}
