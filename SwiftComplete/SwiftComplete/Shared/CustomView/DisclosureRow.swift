//
//  DisclosureRow.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 08/11/24.
//

import SwiftUI

public struct DisclosureRow<Label: View>: View {
    public let label: Label
    
    public init(@ViewBuilder label: () -> Label) {
        self.label = label()
    }
    
    public var body: some View {
        HStack {
            label
        }
    }
}
public struct DisclosureRow2<Content, ExtraContent>: View where Content: View, ExtraContent: View{
    let content: Content?
    let extraContent: ExtraContent?
    
    public init(  @ViewBuilder content: () -> Content? = { nil },
                  @ViewBuilder extraContent: () -> ExtraContent? = { nil } ) {
        self.extraContent = extraContent()
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
            extraContent
        }
    }
}

public struct DisclosureRow3<Content: View, Extra: View>: View{
    let content: Content?
    let extra: Extra?
    
    public init (@ViewBuilder content: () -> Content? = { nil} , extra: () -> Extra?  = { nil}) {
        self.content = content()
        self.extra = extra()
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
            extra
        }
    }
}
// added this extension to handle the empty extra view
extension DisclosureRow3 where Extra == EmptyView {
    init (@ViewBuilder content: () -> Content? = { nil}) {
        self.init(
            content: content, extra: { EmptyView() }
        )
    }
}
//------ generate by AI
// Define the DisclosureRow struct
public struct DisclosureRow4<Content: View, Extra: View>: View {
    // Content and extra views for the row
    let content: Content?
    let extra: Extra?
    
    // Row selection handler
    var onSelect: (() -> Void)?
    
    // Controls for displaying disclosure indicator and info button
    var showDisclosureIndicator: Bool
    var showInfoButton: Bool

    // Indicates whether the row is selected
    @State private var isSelected = false

    // Initializer to pass the content, extra, and customization options
    public init(
        @ViewBuilder content: () -> Content? = { nil },
        @ViewBuilder extra: () -> Extra? = { nil },
        onSelect: (() -> Void)? = nil,
        showDisclosureIndicator: Bool = true,
        showInfoButton: Bool = true
    ) {
        self.content = content()
        self.extra = extra()
        self.onSelect = onSelect
        self.showDisclosureIndicator = showDisclosureIndicator
        self.showInfoButton = showInfoButton
    }
    
    // Body of the DisclosureRow
    public var body: some View {
        HStack {
            // Display the content (title, main info)
            if let content = content {
                content
                    .padding(.leading, 16)
                    .padding(.vertical, 10)
                    .foregroundColor(isSelected ? .blue : .primary)  // Highlight on selection
            }
            
            // Spacer to push elements to the right
            Spacer()
            if let extra {
                extra
                    .padding(.trailing, 16)
                    .padding(.vertical, 10)
                    .foregroundColor(isSelected ? .blue : .primary)  
            }
            
            // Display the disclosure indicator (arrow icon)
            if showDisclosureIndicator {
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isSelected ? 90 : 0))
                    .padding(.trailing, 16)
                    .foregroundColor(.gray)
            }
            
            // Display the extra content, like an info button
            if showInfoButton {
                Button(action: {
                    // Action for the info button (can be customized)
                    print("Info button tapped!")
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                        .padding(.trailing, 16)
                }
            }
        }
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            // Handle row selection
            withAnimation {
                isSelected.toggle()
                onSelect?()  // Call the onSelect closure if provided
            }
        }
        .contentShape(Rectangle())  // Ensure the entire row is tappable
    }
}


