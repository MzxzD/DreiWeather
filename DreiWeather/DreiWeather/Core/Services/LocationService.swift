//
//  LocationService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import CoreLocation
import Combine

protocol LocationServiceProtocol {
    var lastKnownLocation: CLLocationCoordinate2D? { get }
    func checkLocationAuthorization()
}

final class LocationService: NSObject, LocationServiceProtocol, ObservableObject {
    @Published private(set) var lastKnownLocation: CLLocationCoordinate2D?
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
    }
    
    func checkLocationAuthorization() {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
} 
