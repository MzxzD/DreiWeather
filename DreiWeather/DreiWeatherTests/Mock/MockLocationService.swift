//
//  MockLocationService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 13.02.25.
//
import CoreLocation

class MockLocationService: LocationServiceProtocol {
    var lastKnownLocation: CLLocationCoordinate2D?
    
    func checkLocationAuthorization() {
        
    }
    
    var authorizationStatus: CLAuthorizationStatus = .authorizedWhenInUse
    
    func requestLocationPermission() {}
    func startUpdatingLocation() {}
    func stopUpdatingLocation() {}
}
