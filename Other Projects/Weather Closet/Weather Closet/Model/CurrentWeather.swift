//
//  CurrentWeather.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 09/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var cityName: String {
        get {
            if _cityName == nil {
                _cityName = ""
            }
            return _cityName
        } set {
            _cityName = newValue
        }
    }
    
    var weatherType: String {
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    
    var currentTemp: Double {
        get {
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        } set {
            _currentTemp = newValue
        }
    }

}

