//
//  WeatherViewModel.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var currentWeather: CurrentWeather?
    @Published var forecast: [DailyForecast] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedCity: String = "New York"
    
    // MARK: - Dependencies
    private let weatherService: WeatherServiceProtocol
    
    // MARK: - Initialization
    init(weatherService: WeatherServiceProtocol = MockWeatherService()) {
        self.weatherService = weatherService
        // Load default city on init
        Task {
            await fetchWeatherData(for: selectedCity)
        }
    }
    
    // MARK: - Public Methods
    func searchCity() async {
        guard !searchQuery.isEmpty else {
            errorMessage = "Please enter a city name"
            return
        }
        
        await fetchWeatherData(for: searchQuery)
        searchQuery = ""
    }
    
    func fetchWeatherData(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let currentWeatherResult = weatherService.fetchCurrentWeather(for: city)
            async let forecastResult = weatherService.fetchForecast(for: city)
            
            let (weather, dailyForecast) = try await (currentWeatherResult, forecastResult)
            
            self.currentWeather = weather
            self.forecast = dailyForecast
            self.selectedCity = weather.city
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Helper Methods
    func formatTemperature(_ temp: Double) -> String {
        return String(format: "%.1f°", temp)
    }
    
    func clearError() {
        errorMessage = nil
    }
}
