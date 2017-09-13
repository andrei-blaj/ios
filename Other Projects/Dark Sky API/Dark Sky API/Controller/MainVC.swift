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

    // Outlets
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    
    // Variables
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = self.locationManager.location
            
            // Passing the current location coordinates to the 'Location' singleton class
            let x = currentLocation.coordinate.latitude as? CLLocationDegrees
            let y = currentLocation.coordinate.longitude as? CLLocationDegrees
            
            Location.instance.latitude = x
            Location.instance.longitude = y
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            
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
                            
                            self.updateLabels()

                        } else {
                            print("> Failed to obtain a response from the API.")
                        }
                    })
                }
            })
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updateLabels() {
        
        cityLbl.text = Location.instance.city
        regionLabel.text = "\(Location.instance.region), \(Location.instance.countryCode)"
        
        temperatureLbl.text = " \(Int(round(DataService.instance.currentConditions.temperature)))°"
        
    }
    

}

