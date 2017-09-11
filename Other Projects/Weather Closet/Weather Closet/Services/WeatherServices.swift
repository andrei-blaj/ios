//
//  WeatherServices.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 10/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire

class WeatherServices {
    
    static let instance = WeatherServices()
    
    var currentWeather = CurrentWeather()
    var forcasts = [Forcast]()
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        let currentWeatherUrl = URL(string: currentWeatherURL(forLatitutde: Location.instance.latitude, andLongitude: Location.instance.longitude))
        
        // Alamofire request
        Alamofire.request(currentWeatherUrl!).responseJSON { (response) in
            if let result = response.result.value as? Dictionary<String, Any> {
                
                if let name = result["name"] as? String {
                    self.currentWeather.cityName = name.capitalized
                }
                
                if let weather = result["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String {
                        self.currentWeather.weatherType = main.capitalized
                    }
                }
                
                if let main = result["main"] as? Dictionary<String, Any> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelsius = currentTemperature - 273.15
                        // let kelvinToFahrenheit = currentTemperature * (9/5) - 459.67
                        
                        self.currentWeather.currentTemp = kelvinToCelsius
                    }
                }
                
            }
            
            completed()
        
        }
        
    }
    
    func downloadForcastDetails(completed: @escaping DownloadComplete) {
        
        let forcastUrl = URL(string: forcastURL(forLatitutde: Location.instance.latitude, andLongitude: Location.instance.longitude, withCount: 10))
        
        // Alamofire request
        Alamofire.request(forcastUrl!).responseJSON { (response) in
            if let result = response.result.value as? Dictionary <String, Any> {
                if let list = result["list"] as? [Dictionary <String, Any>] {
                    for obj in list {
                        let forcast = Forcast(weatherForcast: obj)
                        self.forcasts.append(forcast)
                    }
                }
                
            }
            completed()
        }
        
    }
    
}
