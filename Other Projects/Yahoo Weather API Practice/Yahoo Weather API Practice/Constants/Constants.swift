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

let CODES: Dictionary<String, String> = [ "1": "tropical storm", "2": "hurricane", "3": "severe thunderstorms", "4": "thunderstorms", "5": "mixed rain and snow", "6": "mixed rain and sleet", "7": "mixed snow and sleet", "8": "freezing drizzle", "9": "drizzle", "10": "freezing rain", "11": "showers", "12": "showers", "13": "snow flurries", "14": "light snow showers", "15": "blowing snow", "16": "snow", "17": "hail", "18": "sleet", "19": "dust", "20": "foggy", "21": "haze", "22": "smoky", "23": "blustery", "24": "windy", "25": "cold", "26": "cloudy", "27": "mostly cloudy (night)", "28": "mostly cloudy (day)", "29": "partly cloudy (night)", "30": "partly cloudy (day)", "31": "clear (night)", "32": "sunny", "33": "fair (night)", "34": "fair (day)", "35": "mixed rain and hail", "36": "hot", "37": "isolated thunderstorms", "38": "scattered thunderstorms", "39": "scattered thunderstorms", "40": "scattered showers", "41": "heavy snow", "42": "cattered snow showers", "43": "heavy snow", "44": "partly cloudy", "45": "thundershowers", "46": "snow showers", "47": "isolated thundershowers", "3200": "now available"]
