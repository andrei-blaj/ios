//
//  Forecast.swift
//  Yahoo Weather API Practice
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

class Forecast {
    
    var _code: String!
    var _date: String!
    var _day: String!
    var _high: String!
    var _low: String!
    var _text: String!
    
    // Setters & Getters
    
    // Forecast
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
    
    var day: String {
        get {
            if _day == nil {
                _day = ""
            }
            return _day
        } set {
            _day = newValue
        }
    }
    
    var low: String {
        get {
            if _low == nil {
                _low = ""
            }
            return _low
        } set {
            _low = newValue
        }
    }

    var high: String {
        get {
            if _high == nil {
                _high = ""
            }
            return _high
        } set {
            _high = newValue
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
    
    init(_ forecast: Dictionary<String, Any>) {
        if let forecastCode = forecast["code"] as? String {
            _code = forecastCode
        }
        if let forecastDate = forecast["date"] as? String {
            _date = forecastDate
        }
        if let forecastDay = forecast["day"] as? String {
            _day = forecastDay
        }
        if let forecastHigh = forecast["high"] as? String {
            _high = forecastHigh
        }
        if let forecastLow = forecast["low"] as? String {
            _low = forecastLow
        }
        if let forecastText = forecast["text"] as? String {
            _text = forecastText
        }
    }
    
}
