//
//  SearchCityViewModel.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation
import CoreData

@MainActor
final class SearchCityViewModel: ObservableObject {
    @Published var error: WeatherError?
    @Published var searchText = ""
    @Published private(set) var isLoading = false
    @Published private(set) var weatherData: WeatherResponse?
    
    var onSave: () -> Void
    
    private let weatherService: WeatherServiceProtocol
    private let coreDataService: CoreDataService
    
    init(
        weatherService: WeatherServiceProtocol = WeatherService(),
        coreDataService: CoreDataService = CoreDataService(viewContext: PersistenceController.shared.container.viewContext),
        onSave: @escaping () -> Void
    ) {
        self.weatherService = weatherService
        self.coreDataService = coreDataService
        self.onSave = onSave
    }
    
    func searchWeather() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let weatherData = try await weatherService.fetchWeather(for: searchText)
                self.weatherData = weatherData
            } catch APIError.serverError(let message) {
                self.error = WeatherError(message: message)
            } catch {
                self.error = .serverError
            }
            isLoading = false
        }
    }
    
    func saveCity() {
        do {
            let _ = try coreDataService.saveWeather(weatherData!, isCurrentLocation: false)
            onSave()
        } catch {
            self.error = WeatherError(message: "Couldn't save the entry")
        }
    }
}
