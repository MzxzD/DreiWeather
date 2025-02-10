import SwiftUI

struct WeatherGrid: View {
    let currentWeather: CachedWeather?
    let weatherData: [CachedWeather]
    let selectedWeather: CachedWeather?
    let onSelect: (CachedWeather?) -> Void
    let onDelete: (CachedWeather) -> Void
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
                    withAnimation(Constants.CustomAnimation.defaultSpring) {
                        onSelect(nil)
                    }
                }
        } else {
            CityCard(weather: weather)
                .transition(.scale.combined(with: .opacity))
                .overlay(alignment: .bottomTrailing) {
                    LocationBadge()
                }
                .onTapGesture {
                    withAnimation(Constants.CustomAnimation.defaultSpring) {
                        onSelect(weather)
                    }
                }
        }
    }
    
    @ViewBuilder
    private func weatherCard(_ weather: CachedWeather) -> some View {
        if selectedWeather?.objectID == weather.objectID {
            WeatherCard(weather: .persistable(weather)) {
                onDelete(weather)
            }
            .onTapGesture {
                withAnimation(Constants.CustomAnimation.defaultSpring) {
                    onSelect(nil)
                }
            }
        } else {
            CityCard(weather: weather)
                .onTapGesture {
                    withAnimation(Constants.CustomAnimation.defaultSpring) {
                        onSelect(weather)
                    }
                }
        }
    }
} 
