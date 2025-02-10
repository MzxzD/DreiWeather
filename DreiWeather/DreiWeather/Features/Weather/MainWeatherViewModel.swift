//
//  ContentView.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation
import SwiftUI
import CoreData
import Network
import Combine

@MainActor
final class MainWeatherViewModel: ObservableObject {
    @Published private(set) var weatherData: [CachedWeather] = []
    @Published private(set) var currentLocationWeather: CachedWeather?
    @Published private(set) var isLoading = false
    @Published private(set) var selectedWeather: CachedWeather?
    @Published private(set) var isRefreshing = false
    @Published var showingSearch = false
    @Published var error: WeatherError?
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    private let coreDataService: CoreDataService
    private let locationService: LocationServiceProtocol
    private let networkService: NetworkService
    
    init(
        weatherService: WeatherServiceProtocol = WeatherService(),
        coreDataService: CoreDataService,
        locationService: LocationServiceProtocol = LocationService(),
        networkService: NetworkService = .shared
    ) {
        self.weatherService = weatherService
        self.coreDataService = coreDataService
        self.locationService = locationService
        self.networkService = networkService
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        guard let locationService = locationService as? LocationService else { return
        }
        
        locationService.$lastKnownLocation
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task { await self.fetchCurrentLocationWeather() }
            }
            .store(in: &cancellables)
    }
    
    func fetchData() async {
        isLoading = true
        locationService.checkLocationAuthorization()
        
        do {
            let cachedWeathers = try coreDataService.fetchAllWeather()
            let currentLocationWeather = try coreDataService.fetchWeather(
                predicate: NSPredicate(format: "isCurrentLocation == true")
            )
            
            if networkService.hasNetworkConnection {
                await fetchCurrentLocationWeather()
                try await updateWeatherData(cityNames: cachedWeathers.compactMap(\.cityName))
            } else {
                self.currentLocationWeather = currentLocationWeather
                self.weatherData = cachedWeathers
            }
        } catch {
            self.error = WeatherError.init(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func updateWeatherData(cityNames: [String]) async throws {
        for city in cityNames {
            do {
                let weatherData = try await weatherService.fetchWeather(for: city)
                _ = try coreDataService.saveWeather(weatherData, isCurrentLocation: false)
            } catch let err {
                self.error = WeatherError(message: err.localizedDescription)
                continue
            }
        }
        
        self.weatherData = (try? coreDataService.fetchAllWeather()) ?? []
        isLoading = false
    }
    
    func fetchCurrentLocationWeather() async {
        
        if let coordinate = locationService.lastKnownLocation {
            do {
                isLoading = true
                let weather = try await weatherService.fetchWeatherForLocation(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                currentLocationWeather = try coreDataService.saveWeather(weather, isCurrentLocation: true)
                error = nil
            } catch {
                self.error = WeatherError(message: error.localizedDescription)
            }
        }
    }
    
    func toggleSearch() {
        showingSearch = true
    }
    
    func selectWeather(_ weather: CachedWeather?) {
        Task { @MainActor in
            selectedWeather = weather
        }
    }
    
    func deselectWeather() {
        Task { @MainActor in
            selectedWeather = nil
        }
    }
    
    func deleteWeather(_ weather: CachedWeather) {
        Task { @MainActor in
            coreDataService.delete(weather)
            selectedWeather = nil
            await fetchData()
        }
    }
    
    func refreshData() async {
        isRefreshing = true
        await fetchData()
        isRefreshing = false
    }
    
    func moveWeather(from source: IndexSet, to destination: Int) {
        var updatedWeather = weatherData
        updatedWeather.move(fromOffsets: source, toOffset: destination)
        weatherData = updatedWeather
        coreDataService.updateSortOrder(items: updatedWeather)
    }
}
