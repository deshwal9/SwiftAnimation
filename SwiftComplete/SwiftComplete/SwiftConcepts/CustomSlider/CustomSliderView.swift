//
//  CustomSliderView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

struct CustomSliderView: View {
    @State var volume:CGFloat
    @ObservedObject var vm: CustomSliderVM
    var body: some View {
        //MARK: Sample 2: custom Slider
        List{
            CustomSlider(value: $volume, range: 1...100) {
                HStack {
                    Image (
                        systemName: "speaker.wave.3.fill",
                        variableValue: volume/100
                    )
                    Spacer(minLength: 0)
                    Text(String (format: "%.1f", volume)+"%")
                        .font(.callout)
                        . padding (.horizontal, 20)
                }
            }
        }
        
    }
}

#Preview {
    CustomSliderView(volume: 50, vm: CustomSliderVM())
}
