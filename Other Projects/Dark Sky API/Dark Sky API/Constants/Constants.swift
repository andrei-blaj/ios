//
//  Constants.swift
//  Dark Sky API
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

typealias DownloadComplete = (_ completed: Bool) -> ()

let BASE_URL = "https://api.darksky.net/forecast/"
let API_KEY = "55ea38a504bf2cc73c48d08f25791e5d/"
let UNITS = "auto"

func getDarkSkyURL(forLatitude latitude: Double, andLongitude longitude: Double) -> String {
    let url = "\(BASE_URL)\(API_KEY)\(latitude),\(longitude)?units=\(UNITS)"
    return url
}
