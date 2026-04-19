//
//  OverlappingBottomPanels.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 30/01/2026.
//


import SwiftUI

struct OverlappingBottomPanels: View {

    @State private var animateUpper = false

  var body: some View {
    ZStack(alignment: .bottom) {
      // Background content
      Color(.systemGroupedBackground)
        .ignoresSafeArea()
        .overlay {
          VStack {
            Spacer()
            Text("Main screen content")
              .font(.title2)
              .foregroundStyle(.secondary)
            Spacer()
          }
        }
      
      // ── Lower panel (stays at bottom) ───────────────────────────────
      LowerPanel()
        .zIndex(1)
        .offset(y: animateUpper ? 0 : 0) // always pinned
      
      // ── Upper panel (animates upward) ───────────────────────────────
      UpperPanel()
        .zIndex(2)
        .offset(y: animateUpper ? -UIScreen.main.bounds.height * 0.38 : 0)
        .opacity(animateUpper ? 1 : 0.92)
        .scaleEffect(animateUpper ? 1.0 : 0.96, anchor: .bottom)
    }
    .onAppear {
      withAnimation(.spring(response: 0.68, dampingFraction: 0.74).delay(0.2)) {
        animateUpper = true
      }
    }
  }
}

// ┌─────────────────────────────────────────────────────────────┐
// │                          UPPER PANEL                        │
// └─────────────────────────────────────────────────────────────┘
struct UpperPanel: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.purple.opacity(0.25))
                    .frame(width: 68, height: 68)
                    .overlay {
                        Image(systemName: "music.note")
                            .font(.system(size: 32))
                            .foregroundStyle(.purple)
                    }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Currently Playing")
                        .font(.headline)
                    Text("Artist Name • Album Title (2025)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 20) {
                        Image(systemName: "backward.fill")
                        Image(systemName: "pause.circle.fill")
                            .font(.title)
                        Image(systemName: "forward.fill")
                    }
                    .foregroundStyle(.primary)
                    .padding(.top, 8)
                }

                Spacer()
            }
            .padding(20)

            // Progress bar simulation
            Capsule()
                .frame(height: 4)
                .foregroundStyle(.gray.opacity(0.3))
                .overlay(alignment: .leading) {
                    Capsule()
                        .frame(width: 140, height: 4)
                        .foregroundStyle(.purple)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .padding(.horizontal, 16)
        .padding(.bottom, 70)           // ← space for lower panel
        .shadow(color: .black.opacity(0.18), radius: 16, x: 0, y: 8)
    }
}

// ┌─────────────────────────────────────────────────────────────┐
// │                         LOWER PANEL                         │
// └─────────────────────────────────────────────────────────────┘
struct LowerPanel: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.pink.opacity(0.2))
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: "play.fill")
                        .foregroundStyle(.pink)
                }

            VStack(alignment: .leading, spacing: 3) {
                Text("Mini Player")
                    .font(.subheadline.bold())
                Text("2:18 • Blinding Lights")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 28) {
                Image(systemName: "backward.fill")
                Image(systemName: "pause.fill")
                Image(systemName: "forward.fill")
            }
            .font(.title3)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 66)
        .background(.regularMaterial)
        .clipShape(Rectangle())
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.separator)
        }
    }
}

// ────────────────────────────────────────────────
#Preview {
    OverlappingBottomPanels()
        .preferredColorScheme(.dark) // looks nicer with material
}
