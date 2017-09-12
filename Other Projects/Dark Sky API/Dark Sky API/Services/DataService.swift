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
    
    func downloadDarkSkyData(completed: DownloadComplete) {
        
        let darkSkyURL = getDarkSkyURL(forLatitude: Location.instance.latitude, andLongitude: Location.instance.longitude)
        
        Alamofire.request(darkSkyURL).responseJSON { (response) in
            if let result = response.result.value as? Dictionary<String, Any> {
                
                if let currently = result["currently"] as? Dictionary<String, Any> {
                    // Current Weather
                }
                
                if let minutely = result["minutely"] as? Dictionary<String, Any> {
                    if let summary = minutely["summary"] as? String {
                        
                    }
                    if let icon = minutely["icon"] as? String {
                        
                    }
                    if let data = minutely["data"] as? Dictionary<String, Any> {
                        // Weather by the minute for the next hour
                    }
                }
                
                if let hourly = result["hourly"] as? Dictionary<String, Any> {
                    if let summary = hourly["summary"] as? String {
                    
                    }
                    if let icon = hourly["icon"] as? String {
                        
                    }
                    if let data = hourly["data"] as? Dictionary<String, Any> {
                        // Weather by the hour
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
