//
//  SpeedWaveVM.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 14/12/24.
//

import Foundation
import SwiftUI
import UIKit

enum SwiftUIError: Error {
    case invalidInput
    // Add more error cases as needed
}


class SpeedWaveVM: ObservableObject{
    //func addSpeedWave(value: Int, completion: (Result<Bool, SwiftUIError>)) {
    let boolenValue = false
   
    
    func addSpeedWave(value: Int, completion:  @escaping (Result<Bool, SwiftUIError>) -> Void) {
        print(value)
        if value % 2 == 0 {  // Check if the value is odd (not divisible by 2)
            completion(.success(true))
        } else {
            completion(.failure(SwiftUIError.invalidInput))  // Use .failure for errors
        }
    }

   
}


extension SpeedWaveVM:ViewProvider {
    
    var view: AnyView {
        return AnyView(SpeedWaveView(vm: self))
    }
}



