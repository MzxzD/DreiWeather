//
//  MockNetworkService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 13.02.25.
//

class MockNetworkService: NetworkService {
    var isConnected: Bool = true
    
    var isNetworkAvailable: Bool {
        return isConnected
    }
}
