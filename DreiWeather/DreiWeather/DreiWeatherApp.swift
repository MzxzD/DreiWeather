//
//  DreiWeatherApp.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import SwiftUI
import CoreData

@main
struct DreiWeatherApp: App {
    let persistenceController: NSManagedObjectContext!
    init() {
        guard ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil else {
            persistenceController = nil
            return
        }
        persistenceController = PersistenceController.shared.container.viewContext
        persistenceController.mergePolicy = NSOverwriteMergePolicy
    }
    
    
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                MainWeatherView(viewModel: MainWeatherViewModel(coreDataService: CoreDataService(viewContext: persistenceController)))
            }
            
        }
    }
}
