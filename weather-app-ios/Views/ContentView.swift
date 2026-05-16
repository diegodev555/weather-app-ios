//
//  ContentView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color(.systemBackground)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    Text("Weather App")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    // Search Bar
                    SearchBarView(
                        searchText: $viewModel.searchQuery,
                        onSearch: {
                            Task {
                                await viewModel.searchCity()
                            }
                        }
                    )
                    
                    // Error Message
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    viewModel.clearError()
                                }
                            }
                    }
                    
                    // Loading State
                    if viewModel.isLoading {
                        ProgressView("Loading weather data...")
                            .padding()
                    }
                    
                    // Current Weather Card
                    if let weather = viewModel.currentWeather, !viewModel.isLoading {
                        CurrentWeatherCardView(weather: weather)
                    }
                    
                    // 3-Day Forecast
                    if !viewModel.forecast.isEmpty, !viewModel.isLoading {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("3-Day Forecast")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.forecast) { forecast in
                                ForecastRowView(forecast: forecast)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Empty State
                    if viewModel.currentWeather == nil && !viewModel.isLoading {
                        Text("Search for a city to see the weather")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    ContentView()
}