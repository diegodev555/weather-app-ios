//
//  WeatherModels.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import Foundation

// MARK: - Current Weather Model
struct CurrentWeather: Identifiable, Equatable {
    let id = UUID()
    let city: String
    let temperature: Double
    let condition: WeatherCondition
    let humidity: Int
    let windSpeed: Double
    let feelsLike: Double
    let high: Double
    let low: Double
}

// MARK: - Weather Condition Enum
enum WeatherCondition: String, CaseIterable {
    case sunny = "Sunny"
    case partlyCloudy = "Partly Cloudy"
    case cloudy = "Cloudy"
    case rainy = "Rainy"
    case stormy = "Stormy"
    case snowy = "Snowy"
    case foggy = "Foggy"
    
    var systemImageName: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .partlyCloudy: return "sun.haze.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .stormy: return "cloud.bolt.rain.fill"
        case .snowy: return "cloud.snow.fill"
        case .foggy: return "cloud.fog.fill"
        }
    }
}

// MARK: - Daily Forecast Model
struct DailyForecast: Identifiable, Equatable {
    let id = UUID()
    let day: String
    let date: String
    let high: Double
    let low: Double
    let condition: WeatherCondition
}

// MARK: - Weather Response (for API integration later)
struct WeatherResponse: Decodable {
    let current: CurrentWeatherData?
    let forecast: [ForecastDayData]?
}

struct CurrentWeatherData: Decodable {
    let temp_c: Double
    let condition: ConditionData?
    let humidity: Int
    let wind_kph: Double
    let feelslike_c: Double
}

struct ConditionData: Decodable {
    let text: String
    let icon: String
}

struct ForecastDayData: Decodable {
    let date: String
    let day: DayData?
}

struct DayData: Decodable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: ConditionData?
}