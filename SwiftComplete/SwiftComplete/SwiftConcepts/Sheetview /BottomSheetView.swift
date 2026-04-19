//
//  BottomSheetView.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 16/03/2026.
//
import SwiftUI
// MARK: - Presentation Layer (UI Component)

// SRP: Handles only presentation and gestures
// OCP: Open for extension via parameters
// DIP: Content injected via ViewBuilder
struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let size: SheetSize
    let cornerRadius: CGFloat
    let animation: Animation
    let dismissOnBackgroundTap: Bool

    @ViewBuilder let content: () -> Content

    @GestureState private var dragOffset: CGFloat = 0
    @State private var offset: CGFloat = 0

    init(
        isPresented: Binding<Bool>,
        size: SheetSize = .medium,
        cornerRadius: CGFloat = 16,
        animation: Animation = .easeInOut,
        dismissOnBackgroundTap: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.size = size
        self.cornerRadius = cornerRadius
        self.animation = animation
        self.dismissOnBackgroundTap = dismissOnBackgroundTap
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            if isPresented {
                ZStack(alignment: .bottom) {
                    // Dimmed background
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            if dismissOnBackgroundTap { dismiss() }
                        }

                    // Bottom sheet container
                    VStack(spacing: 0) {
                        // Handle indicator
                        Capsule()
                            .fill(Color.gray.opacity(0.6))
                            .frame(width: 40, height: 6)
                            .padding(.vertical, 8)

                        // Content injection (DIP)
                        content()
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(
                        width: proxy.size.width,
                        height: size.height(for: proxy.size.height)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(Color(.systemBackground))
                    )
                    .offset(y: max(0, offset + dragOffset))
                    .gesture(dragGesture(screenHeight: proxy.size.height))
                    .transition(.move(edge: .bottom))
                    .animation(animation, value: isPresented)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }

    private func dragGesture(screenHeight: CGFloat) -> some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                if value.translation.height > 0 {
                    state = value.translation.height
                }
            }
            .onEnded { value in
                let threshold = size.height(for: screenHeight) * 0.18
                if value.translation.height > threshold {
                    dismiss()
                } else {
                    withAnimation(animation) {
                        offset = 0
                    }
                }
            }
    }

    private func dismiss() {
        withAnimation(animation) {
            isPresented = false
        }
    }
}
