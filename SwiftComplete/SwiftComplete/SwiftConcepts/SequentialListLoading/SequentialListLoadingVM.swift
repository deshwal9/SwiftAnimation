//
//  SequentialListLoadingVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 26/12/24.
//

import Foundation
import SwiftUI
import UIKit



class SequentialListLoadingVM: ObservableObject{
    let items = Array(1...20)
   
   
}


extension SequentialListLoadingVM:ViewProvider {
    
    var view: AnyView {
        return AnyView(SequentialListView(vm: self))
    }
}
