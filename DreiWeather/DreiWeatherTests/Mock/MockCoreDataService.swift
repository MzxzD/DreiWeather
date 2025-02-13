//
//  MockCoreDataService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 13.02.25.
//

import Foundation

class  MockCoreDataService: CoreDataServicable {
    let controller: PersistenceController = .init(inMemory: true)
    var store: [CachedWeather] = []
    
    init() {
    }
    func fetchAllWeather() throws -> [CachedWeather] {
        store.filter{$0.isCurrentLocation == false}.sorted(using: SortDescriptor(\.sortOrder, order: .forward))
    }
    
    func fetchWeather(predicate: NSPredicate) throws -> CachedWeather? {
        ((store as NSArray).filtered(using: predicate) as! [CachedWeather]).first
    }
    
    func saveWeather(_ weather: WeatherResponse, isCurrentLocation: Bool = false) throws -> CachedWeather {
        
        if let weather = store.first(where: {$0.cityName == weather.name}) {
            return weather
        }
        
        let cachedWeather = CachedWeather(context: controller.container.viewContext)
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
            let count = store.count
            cachedWeather.sortOrder = Int32(count)
        }
        
        store.append(cachedWeather)
        return cachedWeather
    }
    
     func delete(_ weather: CachedWeather) {
            store.removeAll(where: { weather.cityName == $0.cityName })
    }
    
     func save() {
       
    }
    
     func undo() {
        
    }
    
     func updateSortOrder(items: [CachedWeather]) {
        for (index, item) in items.enumerated() {
            item.sortOrder = Int32(index)
        }
        store = items
    }
}
