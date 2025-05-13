//
//  TabBarModel.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 12/12/24.
//

import SwiftUI

struct TabBarModel: Identifiable {
    private(set) var  id: Tab
    let size: CGSize = .zero
    let minX: CGFloat = .zero
   
    enum Tab:String,CaseIterable {
        case latest
        case raceWeek
        case topNews
        case xyz
        case cars
        
        var displayName: String{
            switch self {
            case .latest:
                return "Latest"
            case .raceWeek:
                return "RaceWeek"
            case .cars:
                return "Cars"
            case .topNews:
                return "TopNews"
            case .xyz:
                return "XYZ"
            default:
              return ""
            }
        }
    }
}
