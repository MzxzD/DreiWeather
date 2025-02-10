//
//  WeatherCardComponent.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 09.02.2025..
//

import Foundation

enum WeatherCardComponent {
    case persistable(CachedWeather)
    case fetchable(WeatherResponse)
    
    func mapToCardWeather() -> CardWeather {
        switch self {
            
        case .persistable(let weather):
            return CardWeather(
                cityName: weather.cityName,
                icon: weather.icon,
                temperature: weather.temperature,
                description: weather.weatherDescription ?? "",
                feelsLike: weather.temperatureFeelsLike,
                humidity: Int(weather.humidity),
                temperatureMin: weather.temperatureMin,
                temperatureMax: weather.temperatureMax,
                isCurrentLocation: weather.isCurrentLocation,
                lastUpdated: weather.lastUpdated
            )
        case .fetchable(let weather):
            return CardWeather(
                cityName: weather.name,
                icon: weather.weather.first?.icon,
                temperature: weather.main.temp,
                description: weather.weather.first?.description ?? "",
                feelsLike: weather.main.feelsLike,
                humidity: weather.main.humidity,
                temperatureMin: weather.main.tempMin,
                temperatureMax: weather.main.tempMax,
                isCurrentLocation: false,
                lastUpdated: Date()
            )
        }
    }
}

struct CardWeather {
    let cityName: String?
    let icon: String?
    let temperature: Double
    let description: String
    let feelsLike: Double
    let humidity: Int
    let temperatureMin: Double
    let temperatureMax: Double
    let isCurrentLocation: Bool
    let lastUpdated: Date?
}
