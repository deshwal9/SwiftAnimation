//
//  TabBarVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 12/12/24.
//

import Foundation
import SwiftUI

class TabBarVM: ObservableObject{
    let tabItems:[TabBarModel] = [
        .init(id: .raceWeek),
        .init(id: .latest),
        .init(id: .topNews),
        .init(id: .xyz),
        .init(id: .cars)
    ]
    
}

extension TabBarVM:ViewProvider {
    var view: AnyView {
        return AnyView(TabBarView(vm: self))
    }
}
