//
//  ContentView.swift
//  WeatherApp
//
//  Created by Safak Yaral on 17.01.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.cities) { city in
                CityWeatherRow(city: city)
            }
            .navigationTitle("World Weather")
            .refreshable {
                viewModel.fetchRandomCities()
            }
        }
        .onAppear {
            viewModel.fetchRandomCities()
        }
    }
}

struct CityWeatherRow: View {
    let city: City
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.headline)
                Text(city.condition)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(String(format: "%.1f°C", city.temperature))
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
