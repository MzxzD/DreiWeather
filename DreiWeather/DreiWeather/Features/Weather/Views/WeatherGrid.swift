import SwiftUI

struct WeatherGrid: View {
    let currentWeather: CachedWeather?
    let weatherData: [CachedWeather]
    let selectedWeather: CachedWeather?
    let onSelect: (CachedWeather?) async -> Void
    let onDelete: (CachedWeather) async -> Void
    let onRefresh: () async -> Void
    
    var body: some View {
        ScrollView {
            RefreshableScrollView(onRefresh: onRefresh) {
                LazyVStack(spacing: 16) {
                    if let currentWeather {
                        currentLocationView(currentWeather)
                    }
                    ForEach(weatherData) { weather in
                        weatherCard(weather)
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func currentLocationView(_ weather: CachedWeather) -> some View {
        if selectedWeather?.objectID == weather.objectID {
            WeatherCard(weather: .persistable(weather))
                .transition(.scale.combined(with: .opacity))
                .onTapGesture {
                    Task { @MainActor in
                        
                       await onSelect(nil)
                    }
                    
                }
        
    } else {
        CityCard(weather: weather)
            .transition(.scale.combined(with: .opacity))
                .overlay(alignment: .bottomTrailing) {
                    LocationBadge()
                }
                .onTapGesture {
                    Task { @MainActor in
                        await onSelect(weather)
                    }
                }
        }
    }
    
    @ViewBuilder
    private func weatherCard(_ weather: CachedWeather) -> some View {
        if selectedWeather?.objectID == weather.objectID {
            WeatherCard(weather: .persistable(weather)) {
                await onDelete(weather)
            }
            .onTapGesture {
                Task { @MainActor in
                    await onSelect(nil)
                }
            }
        } else {
            CityCard(weather: weather)
                .onTapGesture {
                    Task { @MainActor in
                       await onSelect(weather)
                    }
                }
        }
    }
} 
