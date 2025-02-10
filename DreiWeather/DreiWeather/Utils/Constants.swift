//
//  Constants.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation
import SwiftUI

enum Constants {
    enum API {
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
        static let apiKey = "f5cb0b965ea1564c50c6f1b74534d823"
        static let iconBaseURL = "https://openweathermap.org/img/wn"
    }
    
    enum CustomAnimation {
        static let defaultSpring = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.8)
    }
    
    enum Layout {
        static let cardCornerRadius: CGFloat = 20
        static let defaultPadding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let shadowRadius: CGFloat = 5
        static let defaultVstaskSpacing: CGFloat = 20
        static let smallVstaskSpacing: CGFloat = 12
    }
} 
