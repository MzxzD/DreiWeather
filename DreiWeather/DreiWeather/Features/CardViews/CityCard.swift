//
//  CityCard.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import SwiftUI

struct CityCard: View {
    let weather: CachedWeather
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(weather.cityName ?? "unknown")
                        .font(.title2.bold())
                    Spacer()
                }
                
                HStack(alignment: .bottom) {
                    Text("\(Int(round(weather.temperature)))°")
                        .font(.system(size: 44, weight: .bold))
                    
                    VStack(alignment: .leading) {
                        Text(weather.weatherMain ?? "")
                            .font(.headline)
                        Text(weather.weatherDescription?.capitalized ?? "")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    Spacer()
                }
                
            }
            WeatherIcon(iconCode: weather.icon)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [.cardGradientLight, .cardGradientDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: Constants.Layout.cardCornerRadius))
        .shadow(radius: Constants.Layout.shadowRadius)
    }
}
