import SwiftUI

struct MainWeatherView: View {
    @ObservedObject var viewModel: MainWeatherViewModel
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()
                
                if viewModel.weatherData.isEmpty && viewModel.currentLocationWeather == nil {
                    emptyStateView
                } else {
                    Group {
                        if editMode == .active {
                            WeatherList(
                                currentWeather: viewModel.currentLocationWeather,
                                weatherData: viewModel.weatherData,
                                onMove: viewModel.moveWeather,
                                onRefresh: viewModel.refreshData
                            )
                        } else {
                            WeatherGrid(
                                currentWeather: viewModel.currentLocationWeather,
                                weatherData: viewModel.weatherData,
                                selectedWeather: viewModel.selectedWeather,
                                onSelect: viewModel.selectWeather,
                                onDelete: viewModel.deleteWeather,
                                onRefresh: viewModel.refreshData
                            )
                        }
                    }
                }
            }
            .navigationTitle("weather_title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if editMode == .inactive {
                        addCityButton
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .foregroundStyle(.white)
                }
            }
            .environment(\.editMode, $editMode)
            .foregroundStyle(.white)
            .sheet(isPresented: $viewModel.showingSearch) {
                SearchCityView(viewModel: SearchCityViewModel(onSave: {
                    Task {
                        await viewModel.fetchData()
                    }
                }))
                .transition(.move(edge: .bottom))
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("ok")))
            }
            .task {
                await viewModel.fetchData()
            }
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("cities_unavailable_title", systemImage: "star")
                .foregroundStyle(.white)
        } description: {
            Text("cities_unavailable_body")
                .foregroundStyle(.white.opacity(0.8))
        }
    }
    
    private var addCityButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                viewModel.toggleSearch()
            }
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .semibold))
                .padding(10)
        }
    }
}

