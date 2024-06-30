//
//  NetworkRoute.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation
enum Route {
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    
    case fetchWeatherDetails(CityName: String, units: String, appID: String)
    
    var description: String {
        switch self {
        case .fetchWeatherDetails(CityName: let CityName, units: let units, appID: let appID):
            return "q=\(CityName)&units=\(units)&appid=\(appID)"
        }
    }
}
