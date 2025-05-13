//
//  ButtonFocusModel.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 30/03/2025.
//

import Foundation
import SwiftUICore

class ButtonFocusModel: ObservableObject {

    
    
}
extension ButtonFocusModel:ViewProvider {
    var view: AnyView {
        return AnyView(ButtonFocusView(vm: self))
    }
}



