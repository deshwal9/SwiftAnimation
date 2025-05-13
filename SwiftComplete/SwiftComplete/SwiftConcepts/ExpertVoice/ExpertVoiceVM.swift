//
//  ExpertVoiceVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 16/12/24.
//


import Foundation
import SwiftUI
import UIKit



class ExpertVoiceVM: ObservableObject{
  
   
   
}


extension ExpertVoiceVM:ViewProvider {
    
    var view: AnyView {
        return AnyView(ExpertVoiceView(vm: self))
    }
}


