//
//  CustomSliderVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//
import Foundation
import SwiftUI

class CustomSliderVM:ObservableObject{
    @Published var value:Double = 0.0
}

extension CustomSliderVM:ViewProvider{
    var view: AnyView {
        return AnyView(CustomSliderView(volume: 50.0, vm: self))
    }
}
