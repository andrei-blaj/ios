//
//  DataService.swift
//  Dark Sky API
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class DataService {
    
    static let instance = DataService()
    
    let currentConditions = CurrentConditions()
    var hourlySummary: String!
    var hourlyIcon: String!
    var hourlyForecast = [CurrentConditions]()
    
    func downloadDarkSkyData(completed: @escaping DownloadComplete) {
        
        let darkSkyURL = getDarkSkyURL(forLatitude: Location.instance.latitude, andLongitude: Location.instance.longitude)
        
        Alamofire.request(darkSkyURL).responseJSON { (response) in
            if let result = response.result.value as? Dictionary<String, Any> {
                
                if let currently = result["currently"] as? Dictionary<String, Any> {
                    // Current Weather
                    self.currentConditions.time = currently["time"] as! Double
                    self.currentConditions.summary = currently["summary"] as! String
                    self.currentConditions.icon = currently["icon"] as! String
                    self.currentConditions.precipProbability = currently["precipProbability"] as! Double
                    self.currentConditions.precipIntensity = currently["precipIntensity"] as! Double
                    self.currentConditions.temperature = currently["temperature"] as! Double
                    self.currentConditions.apparentTemperature = currently["apparentTemperature"] as! Double
                    self.currentConditions.humidity = currently["humidity"] as! Double
                    self.currentConditions.pressure = currently["pressure"] as! Double
                    self.currentConditions.windSpeed = currently["windSpeed"] as! Double
                    self.currentConditions.windGust = currently["windGust"] as! Double
                    self.currentConditions.windBearing = currently["windBearing"] as! Double
                    self.currentConditions.cloudCover = currently["cloudCover"] as! Double
                }
                
                // There is also and "minutely" dictionary, but in this case it is not necessary
                
                if let hourly = result["hourly"] as? Dictionary<String, Any> {
                    if let summary = hourly["summary"] as? String { self.hourlySummary = summary }
                    if let icon = hourly["icon"] as? String { self.hourlyIcon = icon }
                    if let data = hourly["data"] as? [Dictionary<String, Any>] {
                        // Weather by the hour
                        for currently in data {
                            let currentHour = CurrentConditions()
                            
                            currentHour.time = currently["time"] as! Double
                            currentHour.summary = currently["summary"] as! String
                            currentHour.icon = currently["icon"] as! String
                            currentHour.precipProbability = currently["precipProbability"] as! Double
                            currentHour.precipIntensity = currently["precipIntensity"] as! Double
                            currentHour.temperature = currently["temperature"] as! Double
                            currentHour.apparentTemperature = currently["apparentTemperature"] as! Double
                            currentHour.humidity = currently["humidity"] as! Double
                            currentHour.pressure = currently["pressure"] as! Double
                            currentHour.windSpeed = currently["windSpeed"] as! Double
                            currentHour.windGust = currently["windGust"] as! Double
                            currentHour.windBearing = currently["windBearing"] as! Double
                            currentHour.cloudCover = currently["cloudCover"] as! Double
                            
                            self.hourlyForecast.append(currentHour)
                        }
                    }
                }
                
                if let daily = result["daily"] as? Dictionary<String, Any> {
                    if let summary = daily["summary"] as? String {
                        
                    }
                    if let icon = daily["icon"] as? String {
                        
                    }
                    if let data = daily["data"] as? Dictionary<String, Any> {
                        // Daily weather
                    }
                }
                
                completed(true)
            } else {
                completed(false)
            }
        }
        
    }
    
    func getLocationData(placemark: CLPlacemark) {
        Location.instance.street = placemark.thoroughfare!
        Location.instance.zip = placemark.postalCode!
        Location.instance.country = placemark.country!
        Location.instance.region = placemark.administrativeArea!
        Location.instance.city = placemark.locality!
        Location.instance.countryCode = placemark.isoCountryCode!
    }
    
}
