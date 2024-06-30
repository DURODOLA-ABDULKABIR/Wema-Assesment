//
//  Protocols.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

protocol WeatherDetailsProtocol: AnyObject {
    func success(weather: [Weather], main: Main, responseCode: String, message: String)
    func noResponse()
}
