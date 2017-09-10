//
//  ViewController.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 09/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherServices.instance.downloadWeatherDetails {
            
        }
        
        WeatherServices.instance.downloadForcastDetails {
            
        }
        
    }


}

