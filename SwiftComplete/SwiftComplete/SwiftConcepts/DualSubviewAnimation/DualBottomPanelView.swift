//
//  DualBottomPanelView.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 30/01/2026.
//


import SwiftUI

struct DualBottomPanelView: View {
    
    @State private var showFirstPanel  = false
    @State private var showSecondPanel = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background / main content
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
                .overlay(
                    VStack(spacing: 20) {
                        Spacer()
                        Text("Some Main Content")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                        Button("Start Animation") {
                            withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) {
                                showFirstPanel = true
                            }
                            
                            // Delayed appearance of second panel
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
                                    showSecondPanel = true
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 120)
                    }
                )
            
            // First panel – slides up from bottom
            if showFirstPanel {
                FirstPanelContent()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
            }
            
            // Second panel – stays at very bottom (tab-bar like or mini player style)
            if showSecondPanel {
                SecondPanelContent()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(2)
            }
        }
        .onAppear {
            // Optional: auto-start animation when view appears
            // DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { ... }
        }
    }
}

// MARK: - Panel Contents

struct FirstPanelContent: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "music.note.list")
                    .font(.system(size: 28))
                    .foregroundStyle(.purple)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Now Playing")
                        .font(.headline)
                    Text("The Weeknd • Blinding Lights")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "play.fill")
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 16)
        .padding(.bottom, 80)     // ← important: leaves space for bottom panel
        .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
    }
}

struct SecondPanelContent: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "music.quarternote.3")
                .font(.system(size: 26))
                .foregroundStyle(.pink)
                .frame(width: 44, height: 44)
                .background(Circle().fill(.pink.opacity(0.15)))
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Mini Player")
                    .font(.subheadline.bold())
                Text("Now playing • 2:14 / 3:45")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 24) {
                Image(systemName: "backward.fill")
                Image(systemName: "pause.fill")
                    .font(.title3)
                Image(systemName: "forward.fill")
            }
            .font(.title3)
            .foregroundStyle(.primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.regularMaterial)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.separator)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 68)
        .background(.ultraThinMaterial)
    }
}

// ────────────────────────────────────────────────
#Preview {
    DualBottomPanelView()
}