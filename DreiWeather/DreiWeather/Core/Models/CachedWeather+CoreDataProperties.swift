//
//  CachedWeather+CoreDataProperties.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 09.02.2025..
//
//

import Foundation
import CoreData


extension CachedWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedWeather> {
        return NSFetchRequest<CachedWeather>(entityName: "CachedWeather")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var humidity: Int32
    @NSManaged public var icon: String?
    @NSManaged public var isCurrentLocation: Bool
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var sortOrder: Int32
    @NSManaged public var temperature: Double
    @NSManaged public var temperatureFeelsLike: Double
    @NSManaged public var temperatureMax: Double
    @NSManaged public var temperatureMin: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var weatherMain: String?

}

extension CachedWeather : Identifiable {

}
