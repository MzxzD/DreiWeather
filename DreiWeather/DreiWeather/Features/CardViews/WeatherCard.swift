//
//  WeatherCard.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 08.02.2025..
//

import Foundation
import SwiftUI

struct WeatherCard: View {
    let weather: CardWeather
    var onDelete: (() async -> Void)?
    @State private var showingDeleteConfirmation = false
    
    init(weather: WeatherCardComponent,
         onDelete: ( () async -> Void)? = nil
    ) {
        self.weather = weather.mapToCardWeather()
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack(spacing: Constants.Layout.smallVstaskSpacing) {
            Text(weather.cityName ?? "N/A")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.white)
            
            HStack(spacing: 20) {
                WeatherIcon(iconCode: weather.icon)
                Text("\(Int(round(weather.temperature)))°")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(.white)
            }
            
            Text(weather.description.capitalized)
                .font(.title2)
                .foregroundStyle(.white.opacity(0.8))
            
            HStack(spacing: 25) {
                WeatherInfoColumn(
                    icon: "thermometer",
                    title: "feels_like",
                    value: "\(Int(round(weather.feelsLike)))°"
                )
                
                WeatherInfoColumn(
                    icon: "humidity",
                    title: "humidity",
                    value: "\(weather.humidity)%"
                )
                
                WeatherInfoColumn(
                    icon: "thermometer.low",
                    title: "min",
                    value: "\(Int(round(weather.temperatureMin)))°"
                )
                
                WeatherInfoColumn(
                    icon: "thermometer.high",
                    title: "max",
                    value: "\(Int(round(weather.temperatureMax)))°"
                )
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: Constants.Layout.cardCornerRadius))
            
            Text("last_updated")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
            Text(weather.lastUpdated?.formatted(date: .abbreviated, time: .shortened) ?? "N/A")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
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
        .toolbar {
            if !weather.isCurrentLocation {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        showingDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .alert("delete_weather".localized, isPresented: $showingDeleteConfirmation) {
            Button("cancel", role: .cancel) { }
            Button("delete", role: .destructive) {
                deleteCity()
            }
        }
    }
    
    private func deleteCity() {
        Task { @MainActor in
            await self.onDelete!()
        }
    }
}
