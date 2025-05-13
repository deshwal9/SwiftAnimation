//
//  Item.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 06/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
