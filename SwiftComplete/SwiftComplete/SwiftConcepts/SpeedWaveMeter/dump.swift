//
//  dump.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 26/12/24.
//

//MARK: Phase 1 to animate Speed
import SwiftUI

//        .padding()
//        VStack{
//            EqualizerView2()
//           // EqualizerView2(speed: $speed)
//            Button("Update Speed") {
//                speed = 0
//                speed = Int.random(in: 0...200)
//            }
//        }.frame( height: 200)

struct EqualizerView2: View {
    let barCount = 9
    let animationDuration: Double = 0.1
    @State var filedBar: Int = 6
    
    @State private var barHeights: [CGFloat] = (0..<9).map { _ in 200 }
    @State private var barColors: [Color] = Array(repeating: .gray, count: 9) // Initial colors
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ForEach(0..<barCount, id: \.self) { index in
                VStack (alignment: .leading){
                    // Bars with dynamic heights and animated colors
                    Rectangle()
                        .fill(barColors[index]) // Dynamic color
                        .frame(width: 30, height: barHeights[index])
                        .cornerRadius(4)
                    
                }
            }
        }
        .frame(height: 200) // Fix the total height
        .padding()
        .onAppear {
            startColorAnimation()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    // Timer to animate colors horizontally in sequence
    func startColorAnimation() {
        for index in 0..<filedBar {
            // Delayed animation for each bar
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * animationDuration)) {
                withAnimation(.linear(duration: animationDuration)) {
                    barColors[index] =  BPColor.red.color // Update bar color with animation
                }
            }
        }
        
        // Repeat the animation in a loop
        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(barCount) * animationDuration)) {
            startColorAnimation()
        }
    }
    
}
