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
    let persistenceController = PersistenceController.shared.container.viewContext
    init() {
        persistenceController.mergePolicy = NSOverwriteMergePolicy
    }

    var body: some Scene {
        WindowGroup {
            MainWeatherView(viewModel: MainWeatherViewModel(coreDataService: CoreDataService(viewContext: persistenceController)))
        }
    }
}
