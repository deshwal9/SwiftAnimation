//
//  TextFieldMenuVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import Foundation
import SwiftUI
import UIKit

class TextFieldMenuVM: ObservableObject{
    
    
}
extension TextFieldMenuVM:ViewProvider {
    
    var view: AnyView {
        return AnyView(TextFieldMenuView(vm: self))
    }
    
    
    
}
