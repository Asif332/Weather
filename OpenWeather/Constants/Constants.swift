//
//  Constants.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import Foundation
import UIKit

// The typealias definition
public typealias TableViewDataSourceDelegate = UITableViewDataSource & UITableViewDelegate

struct Constants {
    
    static let baseURLString = "http://api.openweathermap.org/data/2.5"
    static let OpenWeatherApiKey = "28f6fe2ab4d40ebd573e2520b10e14a2"
    static let units =   "metric"
    
    struct WeatherLocation {

        let cityName: String
        let countryCode: String
        /// Returns the location the user is currently at
        static func currentLocation() -> WeatherLocation {
            // Currently default to London until it's
            return londonGB()
        }
        /// Returns the location used for testing
        static func londonGB() -> WeatherLocation {
            return WeatherLocation(cityName: "London", countryCode: "GB")
        }

    }
    struct NavBarTitle {
        static let forcastViewControllerTitle = "Weather Forecast"
    }
    struct AlertMessage {
        
        static let serverError = "Oops! Some thing went wrong. Please try again"
        static let kNoConnection = NSLocalizedString("No Internet Connection", comment: "")
        static let alertTitle  = NSLocalizedString("Alert", comment: "")

        
    }

}
