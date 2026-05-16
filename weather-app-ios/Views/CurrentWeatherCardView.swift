//
//  CurrentWeatherCardView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct CurrentWeatherCardView: View {
    let weather: CurrentWeather
    let forecast: [DailyForecast]
    
    var body: some View {
        NavigationLink(value: weather) {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var cardContent: some View {
        VStack(spacing: 16) {
            // City Name
            Text(weather.city)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            // Weather Icon and Temperature
            VStack(spacing: 8) {
                Image(systemName: weather.condition.systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                
                Text("\(Int(weather.temperature))°")
                    .font(.system(size: 64, weight: .light, design: .default))
                    .foregroundColor(.white)
                
                Text(weather.condition.rawValue)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            // Weather Details
            HStack(spacing: 24) {
                WeatherDetailItem(
                    icon: "thermometer.half",
                    label: "H:\(Int(weather.high))° L:\(Int(weather.low))°"
                )
                
                WeatherDetailItem(
                    icon: "water.drop.fill",
                    label: "\(weather.humidity)%"
                )
                
                WeatherDetailItem(
                    icon: "wind",
                    label: "\(Int(weather.windSpeed)) km/h"
                )
            }
        }
        .padding(24)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

// MARK: - Weather Detail Item
struct WeatherDetailItem: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white.opacity(0.9))
            
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    CurrentWeatherCardView(
        weather: CurrentWeather(
            city: "New York",
            temperature: 22.5,
            condition: .partlyCloudy,
            humidity: 65,
            windSpeed: 12.5,
            feelsLike: 21.0,
            high: 25.0,
            low: 18.0
        ),
        forecast: [
            DailyForecast(day: "Today", date: "May 16", high: 25, low: 18, condition: .partlyCloudy),
            DailyForecast(day: "Tomorrow", date: "May 17", high: 23, low: 16, condition: .rainy),
            DailyForecast(day: "Wednesday", date: "May 18", high: 27, low: 19, condition: .sunny)
        ]
    )
    .padding()
}
