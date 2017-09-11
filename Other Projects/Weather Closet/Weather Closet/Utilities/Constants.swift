//
//  Constants.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 09/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]

// Current Weather URL
let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let WEATHER = "weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let API_ID = "&appid="
let API_KEY = "5f9d4c815021c1d6f832eda5e2ddf846"

func currentWeatherURL(forLatitutde lat: Double, andLongitude lon: Double) -> String {
    let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(API_ID)\(API_KEY)"
    return CURRENT_WEATHER_URL
}

// Forcast URL
let FORCAST = "forecast/daily?"
let COUNT = "&cnt="

func forcastURL(forLatitutde lat: Double, andLongitude lon: Double, withCount cnt: Int) -> String {
    let FORCAST_URL = "\(BASE_URL)\(FORCAST)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(COUNT)\(cnt)\(API_ID)\(API_KEY)"
    return FORCAST_URL
}
