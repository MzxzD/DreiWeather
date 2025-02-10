//
//  WeatherIcon.swift
//  DreiWeather
//
//  Created by Mateo Doslic on 09.02.2025..
//
import SwiftUI

struct WeatherIcon: View {
    let iconCode: String?
    
    var body: some View {
        if let iconCode {
            AsyncImage(
                url: URL(string: "\(Constants.API.iconBaseURL)/\(iconCode)@2x.png")
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
