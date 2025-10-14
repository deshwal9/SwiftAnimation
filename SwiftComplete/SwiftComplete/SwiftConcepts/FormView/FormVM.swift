//
//  FormVM.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 23/09/2025.
//

import Foundation
import SwiftUI
import UIKit

class FormVM: ObservableObject{
    @Published var loader: LoaderState<Bool> = .success(true)
    
}

extension FormVM:ViewProvider {
    var view: AnyView {
        return AnyView(FormView())
    }
}
