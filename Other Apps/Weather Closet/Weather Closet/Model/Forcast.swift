//
//  Forcast.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 10/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire

class Forcast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    
    var highTemp: String {
        get {
            return _highTemp
        } set {
            _highTemp = newValue
        }
    }
    
    var lowTemp: String {
        get {
            return _lowTemp
        } set {
            _lowTemp = newValue
        }
    }
    
    init(weatherForcast: Dictionary<String, Any>) {
        
        if let temp = weatherForcast["temp"] as? Dictionary<String, Any> {
            if let minTemp = temp["min"] as? Double {
                let kelvinToCelsius = minTemp - 273.15
                _lowTemp = "\(kelvinToCelsius)"
            }
            
            if let maxTemp = temp["max"] as? Double {
                let kelvinToCelsius = maxTemp - 273.15
                _highTemp = "\(kelvinToCelsius)"
            }
        }
        
        if let weather = weatherForcast["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        
        if let date = weatherForcast["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            _date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
