//
//  ListVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 08/11/24.
//
import Foundation
import SwiftUI
import UIKit

class ListVM: ObservableObject{
    var rowSelected = false
   
    func onrowSelection(){
        self.rowSelected.toggle()
        let str = "Hello world"
    }
   
}


extension ListVM:ViewProvider {
    
    var view: AnyView {
        return AnyView(ListView(vm: self))
    }
}
