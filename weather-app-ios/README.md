# Weather App iOS

A SwiftUI weather application built with MVVM architecture. This is a mock UI implementation that demonstrates clean code structure and can be easily connected to a real weather API.

## Project Structure

```
weather-app-ios/
├── Models/
│   └── WeatherModels.swift      # Data models for weather data
├── Services/
│   └── WeatherService.swift     # Weather service protocol and mock implementation
├── ViewModels/
│   └── WeatherViewModel.swift   # ViewModel handling business logic
├── Views/
│   ├── ContentView.swift        # Main screen
│   ├── SearchBarView.swift      # Search bar component
│   ├── CurrentWeatherCardView.swift  # Current weather display
│   └── ForecastRowView.swift    # Forecast list item
├── Assets.xcassets/             # App assets
├── Preview Content/             # Preview assets
└── weather_app_iosApp.swift     # App entry point
```

## Features

- **Search Bar**: Search for any city to get weather information
- **Current Weather Card**: Displays current temperature, condition, humidity, wind speed, and high/low temperatures
- **3-Day Forecast**: Shows weather forecast for the next 3 days
- **Mock Data**: Pre-configured mock data for popular cities (New York, London, Tokyo, Paris, Sydney)
- **Random Generation**: For unknown cities, random weather data is generated

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** pattern:

### Models
- `CurrentWeather`: Represents current weather data
- `DailyForecast`: Represents daily forecast data
- `WeatherCondition`: Enum for weather conditions with SF Symbols

### Services
- `WeatherServiceProtocol`: Protocol defining weather service interface
- `MockWeatherService`: Mock implementation with sample data

### ViewModels
- `WeatherViewModel`: Manages state, handles search, and coordinates between views and services

### Views
- `ContentView`: Main container view
- `SearchBarView`: Custom search bar with clear button
- `CurrentWeatherCardView`: Styled card showing current weather
- `ForecastRowView`: Row component for forecast items

## Usage

1. Open the project in Xcode
2. Build and run on simulator or device
3. Enter a city name in the search bar
4. Tap "Search" or press Return

### Sample Cities with Pre-configured Data
- New York
- London
- Tokyo
- Paris
- Sydney

Enter any other city name to see randomly generated weather data.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Future Enhancements

- Connect to real weather API (e.g., OpenWeatherMap, WeatherAPI)
- Add location-based weather using CoreLocation
- Support for multiple cities/favorites
- Weather alerts and notifications
- Detailed hourly forecast
- Weather maps
- Dark mode support
- Unit tests

## License

MIT License