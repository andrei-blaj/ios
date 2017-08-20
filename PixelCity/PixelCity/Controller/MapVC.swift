//
//  MapVC.swift
//  PixelCity
//
//  Created by Andrei-Sorin Blaj on 18/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {
    
    // Outlets
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapViewBottomConstraint: NSLayoutConstraint!
    
    // Variables
    var locationManager = CLLocationManager()
    
    // Constants
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        configureLocationServices()
        
        addDoubleTap()
        
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender: )))
        
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
    
        mapView.addGestureRecognizer(doubleTap)
    }

    func animateViewUp() {
        mapViewBottomConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded() // 'Refreshes' the view showing the result after applying the new constraints
        }
    }
    
    @IBAction func centerMapBtnPressed(_ sender: Any) {
        
        // Recenters to the user's location
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
        
    }
    
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        
        return pinAnnotation
    }
    
    func centerMapOnUserLocation() {
        
        guard let coordinate = locationManager.location?.coordinate else { return } // coordinate holds the location coordinates of the user
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0) // Holds the Region with 1000m on each side
        
        mapView.setRegion(coordinateRegion, animated: true) // Zooms to that specific region
        
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin()
        
        // drop the pin on the map
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
}

extension MapVC: CLLocationManagerDelegate {
    
    func configureLocationServices() {
        // Requesting authorization for using the user's location from the user
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
    
}
