//
//  CustomSlider.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 09/11/24.
//

import SwiftUI

struct CustomSlider<Overlay:View>: View {
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat> = 1...100
    var config: Config
    var overlay: Overlay
   
   
    init(value: Binding<CGFloat>, range: ClosedRange<CGFloat>, config:Config = .init(), overlay: @escaping ()->Overlay) {
        self._value = value
        self.range = range
        self.config = config
        self.overlay = overlay()
        self.lastStoredValue = value.wrappedValue
    }
    // view properies
    @State var lastStoredValue: CGFloat
    @GestureState private var isActive: Bool = false
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let width = (value/range.upperBound) * size.width
            HStack{
                ZStack(alignment: .leading){
                    Rectangle()
                        .fill(config.inActiveTint)
                    Rectangle()
                        .fill(config.activeTint)
                        .mask(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                        }
                    ZStack(alignment: .leading){
                        overlay
                            .foregroundStyle(config.overlayInActiveTint)
                        overlay
                            .foregroundStyle(config.overlayActiveTint)
                            .mask(alignment: .leading) {
                                Rectangle()
                                    .frame(width: width)
                            }
                        
                    }
                    .compositingGroup()
                    .animation(.easeInOut(duration: 0.3).delay(isActive ? 0.12 :0).speed( isActive ? 1 : 2)){
                        $0
                        .opacity(isActive ? 1 : 0)
                    }
                    
                }
                // .clipShape(.rect(cornerRadius: config.cornerRadius))
               //  .contentShape(.rect(cornerRadius: config.cornerRadius))
                 .contentShape(.rect)
                 .highPriorityGesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isActive) { _, out, _    in
                            out = true
                        }
                        .onChanged { value in
                            let progress = ((value.translation.width/size.width) * range.upperBound) * lastStoredValue
                            self.value = max(min(progress, range.upperBound), range.lowerBound)
                        }.onEnded {  _ in
                           // lastStoredValue = value
                        }
                 )
//                Slider(value: $value, in: range)
//                    .padding(.horizontal, config.extraHeight)
            }
        }.frame(height: 20 + config.extraHeight)
         .mask {
             RoundedRectangle(cornerRadius: config.cornerRadius)
                 .frame(height: 20 + (isActive ? config.extraHeight :0 ))
            }
         .animation(.snappy, value: isActive)
    }
    
}
struct Config {
    var inActiveTint: Color = .black.opacity(0.06)
    var activeTint: Color = Color.primary
    var cornerRadius: CGFloat = 15
    var extraHeight: CGFloat = 25
    /// Overlay Properties
    var overlayActiveTint: Color = .white
    var overlayInActiveTint: Color = .black
}

#Preview {
    ListView(vm: ListVM())
}
