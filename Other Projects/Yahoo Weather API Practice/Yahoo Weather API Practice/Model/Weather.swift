//
//  Weather.swift
//  Yahoo Weather API Practice
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

class Weather {
    
    // Units
    var _distance: String! // "mi"
    var _pressure: String! // "in"
    var _speed: String! // "mph"
    var _temperature: String! // "F"
    
    // Location
    var _city: String!
    var _country: String!
    var _region: String!

    // Wind
    var _windChill: String! // chill: wind chill in degrees (integer)
    var _windDirection: String! // direction: wind direction, in degrees (integer)
    var _windSpeed: String! // speed: wind speed, in the units specified in the speed attribute of the yweather:units element (mph or kph). (integer)
    
    // Atmosphere
    var _atmosphericHumidity: String! // humidity: humidity, in percent (integer)
    var _atmosphericPressure: String!
    var _atmosphericVisibility: String! // visibility, in the units specified by the distance attribute of the yweather:units element (mi or km). Note that the visibility is specified as the actual value * 100. For example, a visibility of 16.5 miles will be specified as 1650. A visibility of 14 kilometers will appear as 1400. (integer)
    var _atmosphericRising: String! // rising: state of the barometric pressure: steady (0), rising (1), or falling (2)

    // Astronomy
    var _sunrise: String!
    var _sunset: String!
    
    // Condition
    var _code: String!
    var _date: String!
    var _temp: String!
    var _text: String!
    
    // Setters & Getters
    
    // Units
    var distance: String {
        get {
            if _distance == nil {
                _distance = ""
            }
            return _distance
        } set {
            _distance = newValue
        }
    }
    
    var pressure: String {
        get {
            if _pressure == nil {
                _pressure = ""
            }
            return _pressure
        } set {
            _pressure = newValue
        }
    }
    
    var speed: String {
        get {
            if _speed == nil {
                _speed = ""
            }
            return _speed
        } set {
            _speed = newValue
        }
    }
    
    var temperature: String {
        get {
            if _temperature == nil {
                _temperature = ""
            }
            return _temperature
        } set {
            _temperature = newValue
        }
    }
    
    // Location
    var city: String {
        get {
            if _city == nil {
                _city = ""
            }
            return _city
        } set {
            _city = newValue
        }
    }
    
    var country: String {
        get {
            if _country == nil {
                _country = ""
            }
            return _country
        } set {
            _country = newValue
        }
    }

    var region: String {
        get {
            if _region == nil {
                _region = ""
            }
            return _region
        } set {
            _region = newValue
        }
    }
    
    // Wind
    var windChill: String {
        get {
            if _windChill == nil {
                _windChill = ""
            }
            return _windChill
        } set {
            _windChill = newValue
        }
    }
    
    var windDirection: String {
        get {
            if _windDirection == nil {
                _windDirection = ""
            }
            return _windDirection
        } set {
            _windDirection = newValue
        }
    }
    
    var windSpeed: String {
        get {
            if _windSpeed == nil {
                _windSpeed = ""
            }
            return _windSpeed
        } set {
            _windSpeed = newValue
        }
    }
    
    // Atmosphere
    var atmosphericHumidity: String {
        get {
            if _atmosphericHumidity == nil {
                _atmosphericHumidity = ""
            }
            return _atmosphericHumidity
        } set {
            _atmosphericHumidity = newValue
        }
    }
    
    var atmosphericPressure: String {
        get {
            if _atmosphericPressure == nil {
                _atmosphericPressure = ""
            }
            return _atmosphericPressure
        } set {
            _atmosphericPressure = newValue
        }
    }
    
    var atmosphericVisibility: String {
        get {
            if _atmosphericVisibility == nil {
                _atmosphericVisibility = ""
            }
            return _atmosphericVisibility
        } set {
            _atmosphericVisibility = newValue
        }
    }
    
    var atmosphericRising: String {
        get {
            if _atmosphericRising == nil {
                _atmosphericRising = ""
            }
            return _atmosphericRising
        } set {
            _atmosphericRising = newValue
        }
    }
    
    // Astronomy
    var sunrise: String {
        get {
            if _sunrise == nil {
                _sunrise = ""
            }
            return _sunrise
        } set {
            _sunrise = newValue
        }
    }
    
    var sunset: String {
        get {
            if _sunset == nil {
                _sunset = ""
            }
            return _sunset
        } set {
            _sunset = newValue
        }
    }
    
    // Condition
    var code: String {
        get {
            if _code == nil {
                _code = ""
            }
            return _code
        } set {
            _code = newValue
        }
    }
    
    var date: String {
        get {
            if _date == nil {
                _date = ""
            }
            return _date
        } set {
            _date = newValue
        }
    }
    
    var temp: String {
        get {
            if _temp == nil {
                _temp = ""
            }
            return _temp
        } set {
            _temp = newValue
        }
    }
    
    var text: String {
        get {
            if _text == nil {
                _text = ""
            }
            return _text
        } set {
            _text = newValue
        }
    }
    
}

