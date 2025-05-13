//
//  ConcurrencyModel.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 06/11/24.
//

import Foundation
import SwiftUICore

class ConcurrencyModel: ObservableObject {

    
    
}
extension ConcurrencyModel:ViewProvider {
    var view: AnyView {
        return AnyView(ConcurrencyView(vm: self))
    }
    func getData() async throws-> CurrentData?{
        // "https://ember-sparkly-rule.glitch.me/current-date"
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Url is incorrect")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
         return try? JSONDecoder().decode(CurrentData.self, from: data)
    }
    
}


struct CurrentData: Decodable, Identifiable {
    let id = UUID()
    let date: String
    private enum CodingKeys: String, CodingKey {
        case date
    }
   
}
