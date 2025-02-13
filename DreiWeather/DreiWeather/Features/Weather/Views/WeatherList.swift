import SwiftUI

struct WeatherList: View {
    let currentWeather: CachedWeather?
    let weatherData: [CachedWeather]
    let onMove: (IndexSet, Int) -> Void
    let onRefresh: () async -> Void
    
    var body: some View {
        List {
            if let currentWeather {
                CityCard(weather: currentWeather)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .disabled(true)
            }
            
            ForEach(weatherData) { weather in
                CityCard(weather: weather)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .onMove(perform: onMove)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
} 
