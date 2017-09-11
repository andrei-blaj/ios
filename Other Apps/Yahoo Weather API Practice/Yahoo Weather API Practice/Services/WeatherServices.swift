//
//  WeatherServices.swift
//  Yahoo Weather API Practice
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Alamofire

class WeatherServices {
    
    static let instance = WeatherServices()
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        
        let yahooWeatherURL = yahooWeatherUrl(forLatitude: Location.instance.latitude, andLongitude: Location.instance.longitude)
        
        Alamofire.request(yahooWeatherURL).responseJSON { (response) in
            if let result = response.result.value as? Dictionary<String, Any> {
                
                if let query = result["query"] as? Dictionary<String, Any> {
                    if let results = query["results"] as? Dictionary<String, Any> {
                        if let channel = results["channel"] as? Dictionary<String, Any> {
                            if let location = channel["location"] as? Dictionary<String, Any> {
                                let city = location["city"] as! String
                                let region = location["region"] as! String
                                let country = location["country"] as! String
                                
                                print("\(city)\(region), \(country)")
                            }
                        }
                    }
                }
            
            }
            completed()
        }
        
    }
    
}
