//
//  BackgroundGradient.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 09.02.2025..
//

import SwiftUI


struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.weatherGradientLight, .weatherBackground],
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
        EmptyView()
    }
}
