//
//  WeatherService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
    func fetchWeatherForLocation(latitude: Double, longitude: Double) async throws -> WeatherResponse
}

final class WeatherService: WeatherServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard let url = APIEndpoint.weather(city: city).url else {
            throw APIError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    func fetchWeatherForLocation(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        guard let url = APIEndpoint.weatherByLocation(lat: latitude, lon: longitude).url else {
            throw APIError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    private func performRequest(url: URL) async throws -> WeatherResponse {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(errorResponse.message)
            }
            throw APIError.serverError("server_error".localized)
        }
        
        do {
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
} 
