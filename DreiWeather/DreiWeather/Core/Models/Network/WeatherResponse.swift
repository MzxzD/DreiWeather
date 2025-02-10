//
//  WeatherResponse.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation


struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let cod: Int
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }
} 
