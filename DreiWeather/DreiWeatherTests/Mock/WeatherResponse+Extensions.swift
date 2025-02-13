//
//  WeatherResponse+Extensions.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 13.02.25.
//

extension WeatherResponse {
    static func mock(name: String? = nil) -> Self {
        .init(
            weather: [
                .init(
                    id: 1,
                    main: "Vienna",
                    description: "",
                    icon: ""
                )
            ],
            main: .init(
                temp: 20,
                feelsLike: 20,
                tempMin: 19,
                tempMax: 25,
                humidity: 59
            ),
            name: name ?? "Vienna",
            cod: 1
        )
    }
}
