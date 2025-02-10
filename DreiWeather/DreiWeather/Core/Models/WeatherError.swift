//
//  WeatherError.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//
//

import Foundation

struct WeatherError: LocalizedError, Identifiable {
    var id: UUID = UUID()
    let message: String
    
    var errorDescription: String? {
        message
    }
    
    static let networkError = WeatherError(message: "error.network".localized)
    static let locationError = WeatherError(message: "error.location_disabled".localized)
    static let serverError = WeatherError(message: "error.server".localized)
} 
