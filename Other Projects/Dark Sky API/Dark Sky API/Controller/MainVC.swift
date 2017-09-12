//
//  MainVC.swift
//  Dark Sky API
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import CoreLocation

class MainVC: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = self.locationManager.location
            
            // Passing the current location coordinates to the 'Location' singleton class
            Location.instance.latitude = currentLocation.coordinate.latitude
            Location.instance.longitude = currentLocation.coordinate.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: Location.instance.latitude, longitude: currentLocation.coordinate.longitude)
            
            // Getting the correct information about the user's location
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error == nil {
                    // Place details
                    var placemark: CLPlacemark?
                    placemark = placemarks?[0]
                    
                    DataService.instance.getLocationData(placemark: placemark!)
                    DataService.instance.downloadDarkSkyData(completed: { (success) in
                        if success {
                            print("> Success")
                        } else {
                            print("> Failed to obtain a response from the API.")
                        }
                    })
                }
            })
            
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    

}

