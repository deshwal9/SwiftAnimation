//
//  ViewProvider.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 06/11/24.
//

import Foundation
import SwiftUI


/// Allow main BaseContentVM to create companion view
protocol ViewProviderBase: BaseModel {
    
}

protocol ViewProvider{
    
    /// Configurable screen content
    var view: AnyView { get }
}
