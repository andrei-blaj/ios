//
//  Location.swift
//  Weather Closet
//
//  Created by Andrei-Sorin Blaj on 11/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import CoreLocation

class Location {
    
    static var instance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
