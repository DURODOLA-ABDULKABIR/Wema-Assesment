//
//  Constants.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

struct HeaderConstant {
    static let applicationJson = "application/json"
    static let contentType = "Content-Type"
    static let tokenHeader = "Authorization"
    static let accept = "Accept"
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

struct AppID {
    static let appID = "fd6189e087550e277f1ff2a8c51423ab"
    
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}

