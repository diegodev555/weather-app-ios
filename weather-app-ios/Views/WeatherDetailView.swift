//
//  WeatherDetailView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: CurrentWeather
    let forecast: [DailyForecast]
    @State private var showContent = false
    
    var hourlyForecast: [HourlyForecast] {
        let hours = ["Now", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM"]
        let temps = stride(from: weather.temperature, through: weather.temperature - 3, by: -0.5).map { $0 }
        let conditions: [WeatherCondition] = [.sunny, .partlyCloudy, .partlyCloudy, .cloudy, .cloudy, .rainy, .rainy, .cloudy]
        
        return zip(hours, temps).enumerated().map { index, element in
            HourlyForecast(
                time: element.0,
                temperature: element.1,
                condition: conditions[min(index, conditions.count - 1)]
            )
        }
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.8),
                    Color.blue.opacity(0.4),
                    Color(.systemBackground)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Main weather section
                    mainWeatherSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                    
                    // Weather info cards
                    weatherInfoCardsSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                    
                    // Sunrise/Sunset section
                    sunSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                    
                    // Hourly forecast
                    hourlyForecastSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                    
                    // 3-day forecast
                    dailyForecastSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                showContent = true
            }
        }
    }
    
    // MARK: - Main Weather Section
    private var mainWeatherSection: some View {
        VStack(spacing: 16) {
            // Large weather icon
            Image(systemName: weather.condition.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.3), radius: 10)
            
            // Large temperature
            Text("\(Int(weather.temperature))°")
                .font(.system(size: 80, weight: .light, design: .default))
                .foregroundColor(.white)
            
            // City name
            Text(weather.city)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            // Weather condition
            Text(weather.condition.rawValue)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.9))
            
            // High/Low
            Text("H:\(Int(weather.high))° L:\(Int(weather.low))°")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(32)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(color: Color.blue.opacity(0.3), radius: 15, x: 0, y: 8)
    }
    
    // MARK: - Weather Info Cards Section
    private var weatherInfoCardsSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                WeatherInfoCard(
                    icon: "thermometer",
                    title: "Feels Like",
                    value: "\(Int(weather.feelsLike))°"
                )
                
                WeatherInfoCard(
                    icon: "water.drop.fill",
                    title: "Humidity",
                    value: "\(weather.humidity)%"
                )
            }
            
            HStack(spacing: 16) {
                WeatherInfoCard(
                    icon: "wind",
                    title: "Wind",
                    value: "\(Int(weather.windSpeed)) km/h"
                )
                
                WeatherInfoCard(
                    icon: "eye.fill",
                    title: "Visibility",
                    value: "\(weather.visibility) km"
                )
            }
            
            HStack(spacing: 16) {
                WeatherInfoCard(
                    icon: "sun.max.fill",
                    title: "UV Index",
                    value: "\(weather.uvIndex)"
                )
                
                // Empty card for balance
                WeatherInfoCard(
                    icon: "drop.triangle.fill",
                    title: "Pressure",
                    value: "1013 hPa"
                )
            }
        }
    }
    
    // MARK: - Sunrise/Sunset Section
    private var sunSection: some View {
        VStack(spacing: 16) {
            Text("Sunrise & Sunset")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
                // Sunrise
                VStack(spacing: 8) {
                    Image(systemName: "sunrise.fill")
                        .font(.title)
                        .foregroundColor(.orange)
                    
                    Text("Sunrise")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(weather.sunrise)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    Color.white.opacity(0.15)
                )
                .cornerRadius(16)
                
                // Sunset
                VStack(spacing: 8) {
                    Image(systemName: "sunset.fill")
                        .font(.title)
                        .foregroundColor(.orange)
                    
                    Text("Sunset")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(weather.sunset)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    Color.white.opacity(0.15)
                )
                .cornerRadius(16)
            }
        }
        .padding(20)
        .background(
            Color.white.opacity(0.1)
                .blur(radius: 10)
        )
        .cornerRadius(20)
    }
    
    // MARK: - Hourly Forecast Section
    private var hourlyForecastSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hourly Forecast")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(hourlyForecast) { hour in
                        HourlyForecastRow(hour: hour)
                    }
                }
            }
        }
    }
    
    // MARK: - Daily Forecast Section
    private var dailyForecastSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("3-Day Forecast")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            VStack(spacing: 12) {
                ForEach(forecast) { day in
                    ForecastDayCard(forecast: day)
                }
            }
        }
    }
}

// MARK: - Weather Info Card Component
struct WeatherInfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            Color.white.opacity(0.15)
        )
        .cornerRadius(16)
    }
}

// MARK: - Hourly Forecast Row Component
struct HourlyForecastRow: View {
    let hour: HourlyForecast
    
    var body: some View {
        VStack(spacing: 8) {
            Text(hour.time)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            Image(systemName: hour.condition.systemImageName)
                .font(.title2)
                .foregroundColor(.white)
            
            Text("\(Int(hour.temperature))°")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: 70, height: 90)
        .background(
            Color.white.opacity(0.15)
        )
        .cornerRadius(12)
    }
}

// MARK: - Forecast Day Card Component
struct ForecastDayCard: View {
    let forecast: DailyForecast
    
    var body: some View {
        HStack {
            Text(forecast.day)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(width: 60, alignment: .leading)
            
            Image(systemName: forecast.condition.systemImageName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40)
            
            Spacer()
            
            Text("H:\(Int(forecast.high))°")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("L:\(Int(forecast.low))°")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .padding(.leading, 8)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            Color.white.opacity(0.15)
        )
        .cornerRadius(16)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        WeatherDetailView(
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
        .navigationBarHidden(true)
    }
}