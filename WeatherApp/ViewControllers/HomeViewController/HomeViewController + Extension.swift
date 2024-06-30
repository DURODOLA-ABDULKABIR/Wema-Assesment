//
//  HomeViewController + Extension.swift
//  WeatherApp
//
//  Created by durodola on 30/06/2024.
//

import Foundation

extension HomeViewController: WeatherDetailsProtocol {
    func success(weather: [Weather], main: Main, responseCode: String, message: String) {
        self.loaderIndicator.stopAnimating()
        switch responseCode {
        case "400", "404", "500":
            showAlert(title: "Error", message: message)
        default:
            cityName = cityNameTextfield.text ?? ""
            self.gotoWeatherDetails(weather: weather, main: main, cityName: cityName)
        }
    }
    
    func noResponse() {
        self.loaderIndicator.stopAnimating()
    }
}
