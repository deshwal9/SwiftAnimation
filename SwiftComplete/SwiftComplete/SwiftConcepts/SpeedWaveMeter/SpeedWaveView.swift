//
//  SpeedWaveView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 14/12/24.
//
import SwiftUI

struct SpeedWaveView: View {
    @ObservedObject var vm: SpeedWaveVM
    @State var speed: Int? = 50
    let columnCount: Int = 10
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width - 55 // Total available width
            let coloumWidth = totalWidth / CGFloat(columnCount)
            IncrementalColumnFillView2(coloumWidth: coloumWidth)
        }
        .frame(height: 250)
//        VStack{
//            IncrementalColumnFillView()
//                        .frame(height: 250)
//        }
    }
}


#Preview {
    SpeedWaveView(vm: SpeedWaveVM())
}

//MARK: Final code
struct IncrementalColumnFillView: View {
    let animationDuration: Double = 0.1
    let columnCount: Int = 10 // Number of columns
    @State var filedBar: Int = 5
    
    // Array of SpeedColumn structs, one for each column
    @State private var columns: [SpeedColumn]
    
    init() {
        // Initialize all columns with 0 width (not filled) and gray color
        _columns = State(initialValue: Array(repeating: SpeedColumn(width: 100), count: columnCount))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width - 55 // Total available width
            let columnWidth = totalWidth / CGFloat(columnCount) // Fixed width of each column
            
            HStack(spacing: 5) { // Add spacing between columns
                ForEach(0..<columnCount, id: \.self) { index in
                    Rectangle()
                        .fill(columns[index].barColors)
                        .frame(width: columns[index].filedWidths, height: geometry.size.height) // Column width based on filled width
                        .animation(.easeIn(duration: 0.1), value: columns[index].filedWidths) // Smooth animation for width
                }
            }
            .onAppear {
                animateColumns(targetWidth: columnWidth)
            }
        }
        .padding(.horizontal, 5)
    }
    
    func animateColumns(targetWidth: CGFloat) {
        // Animate the filling of columns with color
        for i in 0..<filedBar {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * animationDuration) {
                incrementColumnWidth(index: i, targetWidth: targetWidth)
                columns[i].barColors = .red // Set the color to red when the column is filling
            }
        }
        
        // Animate the removal of the color and decreasing width in reverse
        for i in (0..<filedBar).reversed() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(filedBar) * animationDuration + 0.5) {
                decrementColumnWidth(index: i, targetWidth: targetWidth)
                columns[i].barColors = .gray // Reset the color to gray once the column is emptied
            }
        }
    }
    
    func incrementColumnWidth(index: Int, targetWidth: CGFloat) {
        // Gradually increment the width for the column
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if columns[index].filedWidths < targetWidth {
                columns[index].filedWidths += 3 // Increment the width in small steps
            } else {
                columns[index].filedWidths = targetWidth // Ensure it reaches exactly the target width
                timer.invalidate() // Stop the timer when fully filled
            }
        }
    }
    
    func decrementColumnWidth(index: Int, targetWidth: CGFloat) {
        // Gradually decrement the width for the column
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if columns[index].filedWidths > 0 {
                columns[index].filedWidths -= 3 // Decrement the width in small steps
            } else {
                columns[index].filedWidths = 0 // Ensure it reaches exactly 0
                columns[index].barColors = .gray // Reset color to gray once width is zero
                timer.invalidate() // Stop the timer when width is fully decreased
            }
        }
    }
}

//MARK: Final code perfectly working fine
struct IncrementalColumnFillView2: View {
    let columnCount: Int
    let coloumWidth: CGFloat
    @State var filedBar: Int = 8
    
    let animationDuration: Double = 5
    @State var animationtime: Double = 0.05
    // column component array
    @State private var columns: [SpeedColumn]
    
    init(coloumWidth : CGFloat = 0.0, columnCount: Int = 10) {
        self.columnCount = columnCount
        self.coloumWidth = coloumWidth
       // _columns = State(initialValue: Array(repeating: SpeedColumn(width: coloumWidth), count: columnCount))
        _columns = State(initialValue: (0..<columnCount).map { _ in
            SpeedColumn(width: coloumWidth) // Create a new SpeedColumn for each element
        })
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 5){
                ForEach(columns.indices, id: \.self) { index in
                    ColumnView(column: $columns[index]) // Pass binding to the subview
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.05) {
                    filledColumn()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.3) {
                    emptyColumn()
                }
            }
        }
    }
    func emptyColumn(){
       // DispatchQueue.main.asyncAfter(deadline: .now() + (Double(0) * animationDuration)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.easeOut(duration: animationDuration)) {
                for i in (0..<filedBar).reversed() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationtime) {
                        decrementColumnWidth(columnIndex: i)
                    }
                    animationtime += 0.15
                }
            }
        }
    }
    func filledColumn(){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.easeIn(duration: animationDuration)) {
                for i in 0..<filedBar {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationtime) {
                        incrementColumnWidth(columnIndex: i)
                        
                    }
                    animationtime += 0.15
                }
            }
        }
    }
    func decrementColumnWidth(columnIndex: Int) {
        // Gradually increment the width for the column
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            var column = columns[columnIndex]
            print(columns[columnIndex].id)
            if column.filedWidths > 0 {
                column.filedWidths -= 2.0
                columns[columnIndex] = column
                 // Increment the width in small steps
                print(column.id)
            } else {
                column.filedWidths = column.width // Ensure it reaches exactly the target width
                timer.invalidate() // Stop the timer when fully filled
            }
        }
    }
    func incrementColumnWidth(columnIndex: Int) {
        // Gradually increment the width for the column
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            var column = columns[columnIndex]
            if column.filedWidths < column.width {
                column.filedWidths += 2.0
                columns[columnIndex] = column
                 // Increment the width in small steps
                print(column.filedWidths)
            } else {
                column.filedWidths = column.width // Ensure it reaches exactly the target width
                timer.invalidate() // Stop the timer when fully filled
            }
        }
    }
}

struct SpeedColumn: Identifiable, CustomStringConvertible {
    var id:UUID = UUID()
    var width: CGFloat
    var filedWidths: CGFloat = 0.0
    var barColors: Color = BPColor.grey.color
    init(id: UUID = UUID(), width: CGFloat) {
        self.id = id
        self.width = width
    }
    var description: String{
        return "\(id) \(width) \(filedWidths)"
    }
}


struct ColumnView: View {
    @Binding var column: SpeedColumn
    var body: some View {
            Rectangle()
                .fill(column.barColors)
                .frame(width: column.width) // Adjust the width of the column
                .overlay(alignment: .leading){
                    Rectangle()
                        .fill(column.filedWidths > 0.0 ? BPColor.red.color : BPColor.grey.color)
                        .frame(width: column.filedWidths) // Width of the progress
                        .alignmentGuide(.leading) { d in d[.leading] } // Align the overlay to the left
                        .animation(.easeIn(duration: 0.1), value: column.filedWidths) // Smooth animation for width
                }
                .animation(.easeIn(duration: 0.1), value: column.filedWidths) // Smooth animation for width
        }
}
