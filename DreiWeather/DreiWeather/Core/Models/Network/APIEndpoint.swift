//
//  APIEndpoint.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation

enum APIEndpoint {
    case weather(city: String)
    case weatherByLocation(lat: Double, lon: Double)
    
    var path: String {
        switch self {
        case .weather, .weatherByLocation:
            return "/data/2.5/weather"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "appid", value: Constants.API.apiKey),
            URLQueryItem(name: "units", value: NSLocale.current.measurementSystem.identifier)
        ]
        
        switch self {
        case .weather(let city):
            items.append(URLQueryItem(name: "q", value: city))
        case .weatherByLocation(let lat, let lon):
            items.append(contentsOf: [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon))
            ])
        }
        
        return items
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
} 
