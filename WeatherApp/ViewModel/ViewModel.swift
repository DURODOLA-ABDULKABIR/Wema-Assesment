//
//  ViewModel.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

class WeatherDetailsNetwork {
    var delegate: WeatherDetailsProtocol?
    func getWeatherDetails(CityName: String, units: String, appID: String) {
        NetworkService.shared.getWeatherDetails(CityName: CityName, units: units, appID: appID) { result in
            switch result {
            case .success(let response):
                
                var responseStringValue = ""
                var message = ""
                var weatherResponse = [Weather]()
                var mainResponse = Main(temp: nil, feelsLike: nil, tempMin: nil, tempMax: nil, pressure: nil, humidity: nil, seaLevel: nil, grndLevel: nil)
                
                if let responseCode = response.cod {
                    switch responseCode {
                    case .int(let value):
                        print("Cod as Int: \(value)")
                    case .string(let value):
                        responseStringValue = value
                    }
                }
                
                if let weather = response.weather {
                    weatherResponse = weather
                }
                
                if let main = response.main {
                    mainResponse = main
                }
                
                if let responseMessage = response.message {
                    message = responseMessage
                }
                
                self.delegate?.success(weather: weatherResponse, main: mainResponse, responseCode: responseStringValue, message: message)
            case .failure(let error):
                print(error)
                self.delegate?.noResponse()
            }
        }
    }
}

class MockWeatherDetailsNetwork: WeatherDetailsNetwork {
    var getWeatherDetailsCalled = false
    override func getWeatherDetails(CityName: String, units: String, appID: String) {
        getWeatherDetailsCalled = true
    }
}
