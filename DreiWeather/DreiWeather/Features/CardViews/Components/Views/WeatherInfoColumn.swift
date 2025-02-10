//
//  WeatherInfoColumn.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 09.02.2025..
//

import SwiftUI

struct WeatherInfoColumn: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.white)
            Text(title.localized)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
    }
}

