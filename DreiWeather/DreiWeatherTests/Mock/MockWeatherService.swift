//
//  MockWeatherService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 13.02.25.
//

import Foundation

class MockWeatherService: WeatherServiceProtocol {
    var shouldFail = false
    var mockWeather: WeatherResponse?
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        if shouldFail {
            throw NSError(domain: "MockError", code: -1)
        }
        return mockWeather ?? WeatherResponse.mock(name: city)
    }
    
    func fetchWeatherForLocation(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        if shouldFail {
            throw NSError(domain: "MockError", code: -1)
        }
        return mockWeather ?? WeatherResponse.mock()
    }
}
