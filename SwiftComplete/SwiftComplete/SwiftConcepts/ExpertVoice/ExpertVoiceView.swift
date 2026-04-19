//
//  ExpertVoiceView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 16/12/24.
//

import SwiftUI

struct ExpertVoiceView: View {
    @ObservedObject var vm: ExpertVoiceVM
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.edgesIgnoringSafeArea(.all)

              LinearGradient(colors: [.purple.opacity(0.4), .red.opacity(0.4), .purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .overlay(
                EqualizerView()
            )
        }
    }
}

#Preview {
    ExpertVoiceView(vm: ExpertVoiceVM())
}

struct EqualizerView: View {
    let barCount = 8
    let animationDuration: Double = 0.2

    @State private var barHeights: [CGFloat] = Array(repeating: 200, count: 8)

    var body: some View {
        HStack(spacing: 2.5) {
            ForEach(0..<barCount, id: \.self) { index in
                let _ = print("Current height: \(barHeights[index])")
                Rectangle()
                    .fill(index % 2 == 0 ? Color.white : Color.clear) // Alternate colors
                    .frame(width:index % 2 == 0 ? 50 : 1, height: barHeights[index])   // Dynamic height
                    .cornerRadius(60)
                    .animation(.bouncy(duration: 0.9),value: barHeights[index])
                    .animation(.easeInOut(duration: animationDuration), value: barHeights[index])
                    .animation(
                        .interactiveSpring(
                            response: 0.4,           // Controls speed (lower = faster bounce)
                            dampingFraction: 0.6,    // Controls bounce intensity
                            blendDuration: 0.2       // Blending time between animations
                        ), value: barHeights[index]
                    )
            }
        }
        .frame(height: 300)
        .frame(maxWidth:.infinity)
        .onAppear {
            startTimer()
        }
        .background(.regularMaterial.opacity(0.1))
    }
    
    // Separate timer logic
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            // Update bar heights randomly
            barHeights = barHeights.map { _ in CGFloat.random(in: 100...200) }
        }
    }
}
