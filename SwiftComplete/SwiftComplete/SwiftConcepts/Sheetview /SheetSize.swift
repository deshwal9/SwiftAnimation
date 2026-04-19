//
//  SheetSize.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 16/03/2026.
//

import SwiftUI

// MARK: - Domain Layer (Business Logic - No UI Dependencies)

enum SheetSize {
    case small
    case medium
    case large
    case custom(CGFloat)
    
    func height(for screenHeight: CGFloat) -> CGFloat {
        switch self {
        case .small: return screenHeight * 0.3
        case .medium: return screenHeight * 0.5
        case .large: return screenHeight * 0.85
        case .custom(let value): return min(value, screenHeight * 0.95)
        }
    }
}

// MARK: - View Modifier Extension (Convenience)

extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        size: SheetSize = .medium,
        cornerRadius: CGFloat = 16,
        animation: Animation = .easeInOut,
        dismissOnBackgroundTap: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheetView(
                isPresented: isPresented,
                size: size,
                cornerRadius: cornerRadius,
                animation: animation,
                dismissOnBackgroundTap: dismissOnBackgroundTap,
                content: content
            )
        }
    }
}

// MARK: - Example Usage

struct ContentView5: View {
    @State private var showSmall = false
    @State private var showMedium = false
    @State private var showLarge = false
    @State private var selectedAction: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Small Sheet") { showSmall.toggle() }
                .buttonStyle(.borderedProminent)
            
            Button("Medium Sheet") { showMedium.toggle() }
                .buttonStyle(.borderedProminent)
            
            Button("Large Sheet") { showLarge.toggle() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        
        // Small sheet example
        .bottomSheet(isPresented: $showSmall, size: .small) {
            VStack(spacing: 16) {
                Text("Confirm Action")
                    .font(.headline)
                Text("Are you sure?")
                    .foregroundColor(.gray)
                HStack(spacing: 12) {
                    Button("Cancel") { showSmall = false }
                        .buttonStyle(.bordered)
                    Button("Confirm") { showSmall = false }
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        
        // Medium sheet example
        .bottomSheet(isPresented: $showMedium, size: .medium) {
            VStack(spacing: 12) {
                Text("Select Action")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                ForEach(["Share", "Save", "Delete"], id: \.self) { action in
                    Button(action: { selectedAction = action; showMedium = false }) {
                        HStack {
                            Text(action)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .foregroundColor(.primary)
                }
                
                Button("Cancel") { showMedium = false }
                    .padding()
            }
            .padding()
        }
        
        // Large sheet example
        .bottomSheet(isPresented: $showLarge, size: .large) {
            VStack(spacing: 16) {
                Text("Details")
                    .font(.headline)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(1...10, id: \.self) { i in
                            HStack {
                                Text("Item \(i)")
                                Spacer()
                                Text("Details")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                
                Button("Close") { showLarge = false }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView5()
}
