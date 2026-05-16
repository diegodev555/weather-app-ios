//
//  WeatherService.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import Foundation

// MARK: - Weather Service Protocol
protocol WeatherServiceProtocol {
    func fetchCurrentWeather(for city: String) async throws -> CurrentWeather
    func fetchForecast(for city: String) async throws -> [DailyForecast]
}

// MARK: - Mock Weather Service
class MockWeatherService: WeatherServiceProtocol {
    
    // Simulated network delay
    private let delay: Double = 0.5
    
    // Mock data for different cities
    private let mockWeatherData: [String: CurrentWeather] = [
        "new york": CurrentWeather(
            city: "New York",
            temperature: 22.5,
            condition: .partlyCloudy,
            humidity: 65,
            windSpeed: 12.5,
            feelsLike: 21.0,
            high: 25.0,
            low: 18.0
        ),
        "london": CurrentWeather(
            city: "London",
            temperature: 15.0,
            condition: .rainy,
            humidity: 82,
            windSpeed: 18.0,
            feelsLike: 13.5,
            high: 17.0,
            low: 12.0
        ),
        "tokyo": CurrentWeather(
            city: "Tokyo",
            temperature: 28.0,
            condition: .sunny,
            humidity: 55,
            windSpeed: 8.0,
            feelsLike: 30.0,
            high: 30.0,
            low: 24.0
        ),
        "paris": CurrentWeather(
            city: "Paris",
            temperature: 18.5,
            condition: .cloudy,
            humidity: 70,
            windSpeed: 10.0,
            feelsLike: 17.0,
            high: 20.0,
            low: 15.0
        ),
        "sydney": CurrentWeather(
            city: "Sydney",
            temperature: 26.0,
            condition: .sunny,
            humidity: 60,
            windSpeed: 15.0,
            feelsLike: 27.0,
            high: 28.0,
            low: 22.0
        )
    ]
    
    private let mockForecastData: [String: [DailyForecast]] = [
        "new york": [
            DailyForecast(day: "Tomorrow", date: "May 17", high: 24.0, low: 17.0, condition: .sunny),
            DailyForecast(day: "Sunday", date: "May 18", high: 26.0, low: 19.0, condition: .partlyCloudy),
            DailyForecast(day: "Monday", date: "May 19", high: 23.0, low: 16.0, condition: .rainy)
        ],
        "london": [
            DailyForecast(day: "Tomorrow", date: "May 17", high: 16.0, low: 11.0, condition: .rainy),
            DailyForecast(day: "Sunday", date: "May 18", high: 18.0, low: 13.0, condition: .cloudy),
            DailyForecast(day: "Monday", date: "May 19", high: 19.0, low: 14.0, condition: .partlyCloudy)
        ],
        "tokyo": [
            DailyForecast(day: "Tomorrow", date: "May 17", high: 29.0, low: 23.0, condition: .sunny),
            DailyForecast(day: "Sunday", date: "May 18", high: 31.0, low: 25.0, condition: .sunny),
            DailyForecast(day: "Monday", date: "May 19", high: 27.0, low: 22.0, condition: .cloudy)
        ],
        "paris": [
            DailyForecast(day: "Tomorrow", date: "May 17", high: 19.0, low: 14.0, condition: .partlyCloudy),
            DailyForecast(day: "Sunday", date: "May 18", high: 21.0, low: 16.0, condition: .sunny),
            DailyForecast(day: "Monday", date: "May 19", high: 22.0, low: 17.0, condition: .sunny)
        ],
        "sydney": [
            DailyForecast(day: "Tomorrow", date: "May 17", high: 27.0, low: 21.0, condition: .sunny),
            DailyForecast(day: "Sunday", date: "May 18", high: 25.0, low: 20.0, condition: .partlyCloudy),
            DailyForecast(day: "Monday", date: "May 19", high: 24.0, low: 19.0, condition: .cloudy)
        ]
    ]
    
    func fetchCurrentWeather(for city: String) async throws -> CurrentWeather {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        let normalizedCity = city.lowercased().trimmingCharacters(in: .whitespaces)
        
        // Return mock data if city exists, otherwise generate random weather
        if let weather = mockWeatherData[normalizedCity] {
            return weather
        }
        
        // Generate random weather for unknown cities
        return generateRandomWeather(for: city)
    }
    
    func fetchForecast(for city: String) async throws -> [DailyForecast] {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        let normalizedCity = city.lowercased().trimmingCharacters(in: .whitespaces)
        
        if let forecast = mockForecastData[normalizedCity] {
            return forecast
        }
        
        // Generate random forecast for unknown cities
        return generateRandomForecast()
    }
    
    // MARK: - Helper Methods
    private func generateRandomWeather(for city: String) -> CurrentWeather {
        let conditions = WeatherCondition.allCases
        let randomCondition = conditions.randomElement() ?? .sunny
        let baseTemp = Double.random(in: 10.0...35.0)
        
        return CurrentWeather(
            city: city.capitalized,
            temperature: baseTemp,
            condition: randomCondition,
            humidity: Int.random(in: 30...90),
            windSpeed: Double.random(in: 5.0...25.0),
            feelsLike: baseTemp + Double.random(in: -2.0...2.0),
            high: baseTemp + Double.random(in: 3.0...7.0),
            low: baseTemp - Double.random(in: 3.0...7.0)
        )
    }
    
    private func generateRandomForecast() -> [DailyForecast] {
        let days = ["Tomorrow", "Sunday", "Monday"]
        let dates = ["May 17", "May 18", "May 19"]
        var forecast: [DailyForecast] = []
        
        for i in 0..<3 {
            let baseTemp = Double.random(in: 15.0...30.0)
            forecast.append(
                DailyForecast(
                    day: days[i],
                    date: dates[i],
                    high: baseTemp + Double.random(in: 3.0...5.0),
                    low: baseTemp - Double.random(in: 3.0...5.0),
                    condition: WeatherCondition.allCases.randomElement() ?? .sunny
                )
            )
        }
        
        return forecast
    }
}

// MARK: - Weather Service Error
enum WeatherServiceError: Error, LocalizedError {
    case invalidCity
    case networkError
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidCity: return "Invalid city name"
        case .networkError: return "Network connection failed"
        case .invalidResponse: return "Invalid response from server"
        }
    }
}