//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Safak Yaral on 17.01.2025.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var cities: [City] = []
    private let apiKey = "031636dfd297b77da38c1c132aa95cdf"
    
    func fetchRandomCities() {
        // List of major cities to randomly select from
        let majorCities = ["London", "New York", "Tokyo", "Paris", "Sydney",
                          "Dubai", "Singapore", "Moscow", "Rio de Janeiro",
                          "Toronto", "Mumbai", "Berlin", "Madrid", "Rome",
                          "Amsterdam"]
        
        // Randomly select 10 cities
        let selectedCities = Array(majorCities.shuffled().prefix(10))
        
        // Fetch weather for each city
        for city in selectedCities {
            fetchWeather(for: city)
        }
    }
    
    private func fetchWeather(for city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(WeatherResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.cities.append(City(
                        name: city,
                        temperature: result.main.temp,
                        condition: result.weather.first?.main ?? "Unknown"
                    ))
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

// API Response structure
struct WeatherResponse: Codable {
    let main: MainWeather
    let weather: [Weather]
}

struct MainWeather: Codable {
    let temp: Double
}

struct Weather: Codable {
    let main: String
}
