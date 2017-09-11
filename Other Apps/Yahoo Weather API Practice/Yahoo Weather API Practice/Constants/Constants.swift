//
//  Constants.swift
//  Yahoo Weather API Practice
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]

// YAHOO Data
let CLIENT_ID = "dj0yJmk9VnVWU25BMWRjU0N3JmQ9WVdrOVZrOXJlbU51TkhNbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1kZg--"
let CLIENT_SECRET = "8449500609b5aeebdcdef4388d640979f53ec219"

func yahooWeatherUrl(forLatitude latitude: Double, andLongitude longitude: Double) -> String {
    let weatherUrl = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(SELECT%20woeid%20FROM%20geo.places%20WHERE%20text%3D%22(\(latitude)%2C\(longitude))%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
    return weatherUrl
}
