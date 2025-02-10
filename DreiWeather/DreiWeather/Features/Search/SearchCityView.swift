//
//  SearchCityView.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 06.02.2025..
//

import SwiftUI

struct SearchCityView: View {
    @ObservedObject var viewModel: SearchCityViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()
                mainContent
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("ok")))
            }
            .navigationTitle("search_city")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("done") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        VStack(spacing: Constants.Layout.defaultVstaskSpacing) {
            SearchBar(
                text: $viewModel.searchText,
                onSearch: {
                viewModel.searchWeather()
            })
            .padding(.horizontal)
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            } else if let weather = viewModel.weatherData {
                weatherCard(weather)
            } else {
                ContentUnavailableView {
                    Label("weather_unavailable_title", systemImage: "magnifyingglass")
                        .foregroundStyle(.white)
                } description: {
                    Text("weather_unavailable_body")
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
        }
    }
    
    @ViewBuilder
    func weatherCard(_ weather: WeatherResponse) -> some View {
        ScrollView {
            VStack(spacing: Constants.Layout.defaultVstaskSpacing) {
                WeatherCard(weather: .fetchable(weather), onDelete: nil)
                
                Button(action: {
                    viewModel.saveCity()
                    dismiss()
                }) {
                    Label("save_weather", systemImage: "save")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
            }
        }
    }
}
