//
//  ErrorResponse.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//


import Foundation

struct ErrorResponse: Decodable {
    let cod: String
    let message: String
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "error.invalid_url".localized
        case .invalidResponse:
            return "error.invalid_response".localized
        case .decodingError:
            return "error.decoding".localized
        case .serverError(let message):
            return message
        case .networkError:
            return "error.network".localized
        }
    }
} 
