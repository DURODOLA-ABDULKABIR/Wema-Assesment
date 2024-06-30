//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by durodola on 30/06/2024.
//

import Foundation

import UIKit
class UserDefault: NSObject {
    
    class func saveCity(cityName: String) {
        UserDefaults.standard.set(cityName, forKey: "saveCity")
        UserDefaults.standard.synchronize()
    }
    
    class func removeSavedCity() {
        UserDefaults.standard.removeObject(forKey: "saveCity")
        UserDefaults.standard.synchronize()
    }
    
    class func getSavedCity() -> String? {
        return UserDefaults.standard.string(forKey: "saveCity")
    }
}
