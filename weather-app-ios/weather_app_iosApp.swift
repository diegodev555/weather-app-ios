//
//  weather_app_iosApp.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

@main
struct weather_app_iosApp: App {
    // MARK: - Properties
    
    /// Controls whether to show the splash screen or the main content
    @State private var showSplash = true
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            // Show SplashView first, then transition to ContentView
            if showSplash {
                SplashView {
                    showSplash = false
                }
                .transition(.opacity)
            } else {
                ContentView()
                    .transition(.opacity)
            }
        }
    }
}