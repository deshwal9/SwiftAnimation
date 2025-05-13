//
//  ColorExtensions.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 16/12/24.
//
import SwiftUI

extension View {
    func setColor(_ ibmColor: BPColor) -> some View {
        return ibmColor.color
    }
    
    
    
}

enum BPColor: String {
    case red
    case grey
    var color: Color {
        let color: Color
        switch self {
        case .red:
            color = Color(red: 237/255, green: 27/255, blue: 43/255)
        case .grey:
            color = Color(red: 38/255, green: 38/255, blue: 38/255)
        }
        return color
    }
    
}
