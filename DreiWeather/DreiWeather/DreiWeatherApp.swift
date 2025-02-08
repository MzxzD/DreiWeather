//
//  DreiWeatherApp.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import SwiftUI

@main
struct DreiWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
