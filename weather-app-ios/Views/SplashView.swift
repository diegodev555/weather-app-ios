//
//  SplashView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Properties
    
    /// Callback triggered when splash screen animation completes
    let onSplashComplete: () -> Void
    
    /// Controls the opacity for fade-in animation
    @State private var opacity: Double = 0.0
    
    /// Duration for the fade-in animation
    private let animationDuration: Double = 1.0
    
    /// Time to wait before navigating away after animation completes
    private let delayBeforeDismiss: Double = 2.0
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Full screen blue background with gradient for depth
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBlue).opacity(0.8),
                    Color(.systemBlue)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Main content with cloud icon and app name
            VStack(spacing: 24) {
                // Large cloud SF Symbol
                Image(systemName: "cloud.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // App name text
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .tracking(0.5)
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
            .opacity(opacity)
        }
        .onAppear {
            // Trigger fade-in animation after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn(duration: animationDuration)) {
                    opacity = 1.0
                }
            }
            
            // Navigate to home screen after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + delayBeforeDismiss) {
                onSplashComplete()
            }
        }
    }
}

// MARK: - Previews

#Preview("Light Mode") {
    SplashView(onSplashComplete: {})
}

#Preview("Dark Mode") {
    SplashView(onSplashComplete: {})
        .preferredColorScheme(.dark)
}