//
//  ExpandableList2VM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 13/12/24.
//

import Foundation
import SwiftUI
import UIKit

class ExpandableList2VM: ObservableObject{
    @Published var loader: LoaderState<Bool> = .success(true)
    let data = MockData.MockData()
    @Published var selectedcell: Set<listItem> = []
    
}

extension ExpandableList2VM:ViewProvider {
    var view: AnyView {
        return AnyView(ExpandableList2View(vm: self))
    }
}


struct listItem: Identifiable,Hashable {
    var id = UUID()
    var title: String
    var description: String
}

struct MockData {
    private static  let discription: String = "Born in the Principality of Monaco on 16th October 1997, Charles Leclerc began racing karts at the age of five. In 2011, he won the CIK-FI KF3 World Cup and the CIK-FIA Academy Trophy. in 2012, he was WSK Champion and in 2013, he finished runner-up in the European and Under 18 class with Fortec Motorsport. One year later, still with Fortec, he took the runner-up spot in the ALPS Championship."
    static var data: [listItem] = [
        listItem(title: "Biography", description: discription),
        listItem(title: "Carrier Stat", description: discription),
        listItem(title: "Related Video", description: discription)
    ]
    static func MockData() ->[listItem]{
        return data
    }
    
}
