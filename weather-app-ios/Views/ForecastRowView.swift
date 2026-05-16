//
//  ForecastRowView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct ForecastRowView: View {
    let forecast: DailyForecast
    
    var body: some View {
        HStack(spacing: 16) {
            // Day and Date
            VStack(alignment: .leading, spacing: 2) {
                Text(forecast.day)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(forecast.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Weather Icon
            Image(systemName: forecast.condition.systemImageName)
                .font(.title2)
                .foregroundColor(.primary)
                .frame(width: 40)
            
            // High/Low Temperatures
            HStack(spacing: 12) {
                Text("\(Int(forecast.high))°")
                    .font(.body)
                    .fontWeight(.medium)
                
                Text("\(Int(forecast.low))°")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(width: 80, alignment: .trailing)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ForecastRowView(
        forecast: DailyForecast(
            day: "Tomorrow",
            date: "May 17",
            high: 24.0,
            low: 17.0,
            condition: .sunny
        )
    )
    .padding()
}