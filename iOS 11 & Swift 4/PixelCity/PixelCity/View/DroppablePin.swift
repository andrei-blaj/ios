//
//  DroppablePin.swift
//  PixelCity
//
//  Created by Andrei-Sorin Blaj on 19/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        
        self.coordinate = coordinate
        self.identifier = identifier
        
        super.init()
    }
    
    
    
    
    
}
