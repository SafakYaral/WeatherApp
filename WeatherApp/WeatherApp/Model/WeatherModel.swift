//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Safak Yaral on 17.01.2025.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let temperature: Double
    let condition: String
}
