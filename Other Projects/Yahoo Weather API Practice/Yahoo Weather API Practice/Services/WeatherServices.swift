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
    
    let currentWeather = Weather()
    var forecasts = [Forecast]()
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        
        let yahooWeatherURL = yahooWeatherUrl(forLatitude: Location.instance.latitude, andLongitude: Location.instance.longitude)
        
        Alamofire.request(yahooWeatherURL).responseJSON { (response) in
            if let result = response.result.value as? Dictionary<String, Any> {
                
                if let query = result["query"] as? Dictionary<String, Any> {
                    if let results = query["results"] as? Dictionary<String, Any> {
                        if let channel = results["channel"] as? Dictionary<String, Any> {
                            
                            if let units = channel["units"] as? Dictionary<String, Any> {
                                self.currentWeather.distance = units["distance"] as! String
                                self.currentWeather.pressure = units["pressure"] as! String
                                self.currentWeather.speed = units["speed"] as! String
                                self.currentWeather.temperature = units["temperature"] as! String
                            }
                            
                            if let location = channel["location"] as? Dictionary<String, Any> {
                                self.currentWeather.city = location["city"] as! String
                                self.currentWeather.country = location["country"] as! String
                                self.currentWeather.region = location["region"] as! String
                            }
                            
                            if let wind = channel["wind"] as? Dictionary<String, Any> {
                                self.currentWeather.windChill = wind["chill"] as! String
                                self.currentWeather.windDirection = wind["direction"] as! String
                                self.currentWeather.windSpeed = wind["speed"] as! String
                            }
                            
                            if let atm = channel["atmosphere"] as? Dictionary<String, Any> {
                                self.currentWeather.atmosphericHumidity = atm["humidity"] as! String
                                self.currentWeather.atmosphericPressure = atm["pressure"] as! String
                                self.currentWeather.atmosphericVisibility = atm["visibility"] as! String
                                self.currentWeather.atmosphericRising = atm["rising"] as! String
                            }
                            
                            if let astronomy = channel["astronomy"] as? Dictionary<String, Any> {
                                self.currentWeather.sunrise = astronomy["sunrise"] as! String
                                self.currentWeather.sunset = astronomy["sunset"] as! String
                            }
                            
                            if let item = channel["item"] as? Dictionary<String, Any> {
                                
                                if let condition = item["condition"] as? Dictionary<String, Any> {
                                    self.currentWeather.code = condition["code"] as! String
                                    self.currentWeather.date = condition["date"] as! String
                                    self.currentWeather.temp = condition["temp"] as! String
                                    self.currentWeather.text = condition["text"] as! String
                                }
                                
                                if let forecast = item["forcast"] as? [Dictionary<String, Any>] {
                                    for obj in forecast {
                                        let dailyForecast = Forecast(obj)
                                        self.forecasts.append(dailyForecast)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                }
            
            }
            completed()
        }
        
    }
    
}
