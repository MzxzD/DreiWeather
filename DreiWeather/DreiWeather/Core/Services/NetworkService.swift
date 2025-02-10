//
//  NetworkService.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Network

class NetworkService {
    static let shared = NetworkService()
    
    private let monitor = NWPathMonitor()
    private var isConnected = true
    
    init() {
        setupMonitor()
    }
    
    private func setupMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    var hasNetworkConnection: Bool {
        isConnected
    }
    
    deinit {
        monitor.cancel()
    }
} 
