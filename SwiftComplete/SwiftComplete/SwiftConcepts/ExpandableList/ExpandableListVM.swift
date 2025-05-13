//
//  ExpandableListVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import Foundation
import SwiftUI
import UIKit

class ExpandableListVM: ObservableObject{
    @Published var loader: LoaderState<Bool> = .success(true)
    
}

extension ExpandableListVM:ViewProvider {
    var view: AnyView {
        return AnyView(ExpandableListView(vm: self))
    }
}
