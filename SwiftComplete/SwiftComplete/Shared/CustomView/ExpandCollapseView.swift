//
//  ExpandCollapseView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

enum LoaderState<T> {
    case inProgress
    case success(T)
    case error(Error)
}
// Collapsed/ Expanded view
///  expanded:  by default the view is collapsed
///  title: title of view
///  action: action triggered on view expanded.
///  loader: loader with state to display spinner,  conent or error.
struct ExpandCollapseView<T, Content>: View where Content: View {
    @Binding var expanded: Bool
    let title: String
    let subTitle: String?
    let icon: String?
    let action: SimpleAction?
    let scroll: Bool
    let bgColor: Color?
    @Binding var loader: LoaderState<T>
    let content: (_ item: T) -> Content
    private let spacerViewId = 1
    
    init(
        expanded: Binding<Bool>,
        title: String,
        subTitle: String? = nil,
        icon: String? = nil,
        action: SimpleAction? = nil,
        scroll: Bool = true,
        bgColor: Color = .black,
        loader: Binding<LoaderState<T>>,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self._expanded = expanded
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.action = action
        self.scroll = scroll
        self._loader = loader
        self.content = content
        self.bgColor = bgColor
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                UnderlinedContent(
                    action: {
                        withAnimation {
                            expanded.toggle()
                            action?()
                            if expanded {
                                if scroll {
                                    proxy.scrollTo(spacerViewId, anchor: .bottom)
                                }
                            }
                        }
                    }
                ) {
                    HStack {
                        Text(title)
                            .foregroundColor(.white)
                        if let subTitle {
                            Text(subTitle)
                                .foregroundColor(.primary)
                        }
                        
                        if let icon {
                            Image(icon)
                                .padding(.all, 4)
                                .background(bgColor ?? .black)
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        Spacer()
                        Image(systemName: expanded ? "plus" :"minus")
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .contentTransition(.symbolEffect(.replace))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 1)) {
                                    expanded.toggle() // change
                                }
                            }
                    }
                }
                if expanded {
                    switch loader {
                    case .inProgress:
                        ProgressView()
                            .scaleEffect(1.55, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle())
                    case .success(let item):
                        content(item)
                    case .error(let error):
                        Text(error.localizedDescription)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                    .frame(minHeight: 0.1)
                    .id(spacerViewId)
            }
        }
    }
}

// Wrapper view to have view expanded on appear.
struct DefaultExpandedView<T, Content>: View where Content: View {
    @State private var expanded = false
    let title: String
    let subTitle: String?
    let icon: String?
    let action: SimpleAction?
    @Binding var loader: LoaderState<T>
    let content: (_ item: T) -> Content
    
    init(
        title: String,
        subTitle: String? = nil,
        icon: String? = nil,
        action: SimpleAction? = nil,
        loader: Binding<LoaderState<T>>,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.action = action
        self._loader = loader
        self.content = content
    }
    
    var body: some View {
        ExpandCollapseView(
            expanded: $expanded,
            title: title,
            subTitle: subTitle,
            icon: icon,
            action: action,
            loader: $loader,
            content: content
        )
    }
}

// Wrapper view to have view collapsed on appear.
struct DefaultCollapsedView<T, Content>: View where Content: View {
    @State private var expanded = false
    let title: String
    let subTitle: String?
    let icon: String?
    let action: SimpleAction?
    let scroll: Bool // Enable/disable scrolling view to the bottom of the content on data load.
    @Binding var loader: LoaderState<T>
    let content: (_ item: T) -> Content
    
    init(
        title: String,
        scroll: Bool = true,
        subTitle: String? = nil,
        icon: String? = nil,
        action: SimpleAction? = nil,
        loader: Binding<LoaderState<T>>,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self.title = title
        self.scroll = scroll
        self.subTitle = subTitle
        self.icon = icon
        self.action = action
        self._loader = loader
        self.content = content
    }
    
    var body: some View {
        ExpandCollapseView(
            expanded: $expanded,
            title: title,
            subTitle: subTitle,
            icon: icon,
            action: action,
            scroll: scroll,
            loader: $loader,
            content: content
        )
    }
}
