//
//  DreiWeatherTests.swift
//  DreiWeatherTests
//
//  Created by Mateo Doslic on 08.02.2025..
//

import XCTest
@testable import DreiWeather

final class MainWeatherViewModelTests: XCTestCase {
    @MainActor
    func testFetchData() async throws {
        //Given
        let coreDataService = MockCoreDataService()
        let _ = try coreDataService.saveWeather(.mock())
        let _ = try coreDataService.saveWeather(.mock(name: "LA"))
        let sut = MainWeatherViewModel(
            weatherService: MockWeatherService(),
            coreDataService: coreDataService
        )
        
        //When
        await sut.fetchData()
        
        //Then
        XCTAssertTrue(sut.weatherData.count == 2)
        
    }
    
    @MainActor
    func testMoveWeather() async throws {
        // Given
        let coreDataService = MockCoreDataService()
        let _ = try coreDataService.saveWeather(.mock(name: "London"))
        let _ = try coreDataService.saveWeather(.mock(name: "Paris"))
        
        let sut = MainWeatherViewModel(
            weatherService: MockWeatherService(),
            coreDataService: coreDataService
        )
        
        // When
        await sut.fetchData()
        // move second element to first
        sut.moveWeather(from: IndexSet(integersIn: 1..<2), to: 0)
        await sut.refreshData()
        
        // Then
        XCTAssertEqual(sut.weatherData[0].cityName, "Paris")
        XCTAssertEqual(sut.weatherData[1].cityName, "London")
        
        //Given
        let _ = try coreDataService.saveWeather(.mock(name: "New York"))
        let _ = try coreDataService.saveWeather(.mock(name: "Vienna"))
        
        // When
        await sut.fetchData()
        // move forth element to first
        sut.moveWeather(from: IndexSet(integersIn: 3..<4), to: 0)
        await sut.refreshData()
        
        // Then
        XCTAssertEqual(sut.weatherData[0].cityName, "Vienna")
        XCTAssertEqual(sut.weatherData[1].cityName, "Paris")
        XCTAssertEqual(sut.weatherData[2].cityName, "London")
        XCTAssertEqual(sut.weatherData[3].cityName, "New York")
    }
    
    @MainActor
    func testDeleteWeather() async throws {
        // Given
        let coreDataService = MockCoreDataService()
        
        let weather = try coreDataService.saveWeather(.mock(name: "London"))
        
        let sut = MainWeatherViewModel(
            weatherService: MockWeatherService(),
            coreDataService: coreDataService
        )
        
        // When
        await sut.fetchData()
        await sut.selectWeather(weather)
        await sut.deleteWeather(weather)
        
        // Then
        XCTAssertTrue(sut.weatherData.isEmpty)
        XCTAssertNil(sut.selectedWeather)
    }
    
}
