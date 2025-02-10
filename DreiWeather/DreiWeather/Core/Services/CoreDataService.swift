//
//  CoreDataService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import CoreData

final class CoreDataService {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchAllWeather() throws -> [CachedWeather] {
        let request = CachedWeather.fetchRequest()
        request.predicate = NSPredicate(format: "isCurrentLocation == false")
        request.sortDescriptors = [NSSortDescriptor(key: "sortOrder", ascending: true)]
        return try viewContext.fetch(request)
    }
    
    func fetchWeather(predicate: NSPredicate) throws -> CachedWeather? {
        let request = CachedWeather.fetchRequest()
        request.predicate = predicate
        return try viewContext.fetch(request).first
    }
    
    func saveWeather(_ weather: WeatherResponse, isCurrentLocation: Bool = false) throws -> CachedWeather {
        let cachedWeather = CachedWeather(context: viewContext)
        cachedWeather.cityName = weather.name
        cachedWeather.temperature = weather.main.temp
        cachedWeather.temperatureFeelsLike = weather.main.feelsLike
        cachedWeather.temperatureMin = weather.main.tempMin
        cachedWeather.temperatureMax = weather.main.tempMax
        cachedWeather.humidity = Int32(weather.main.humidity)
        cachedWeather.weatherMain = weather.weather.first?.main
        cachedWeather.weatherDescription = weather.weather.first?.description
        cachedWeather.icon = weather.weather.first?.icon
        cachedWeather.isCurrentLocation = isCurrentLocation
        cachedWeather.lastUpdated = Date()
        
        // Set initial sortOrder to the end of the list
        if !isCurrentLocation {
            let request = CachedWeather.fetchRequest()
            request.predicate = NSPredicate(format: "isCurrentLocation == false")
            let count = (try? viewContext.count(for: request)) ?? 0
            cachedWeather.sortOrder = Int32(count)
        }
        
        try viewContext.save()
        return cachedWeather
    }
    
    func delete(_ weather: CachedWeather) {
        do {
            viewContext.delete(weather)
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func save() {
        try? viewContext.save()
    }
    
    func undo() {
        viewContext.rollback()
    }
    
    func updateSortOrder(items: [CachedWeather]) {
        for (index, item) in items.enumerated() {
            item.sortOrder = Int32(index)
        }
        save()
    }
} 
