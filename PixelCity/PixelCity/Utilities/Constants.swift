//
//  Constants.swift
//  PixelCity
//
//  Created by Andrei-Sorin Blaj on 21/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

let API_KEY = "5dd6ff68a529373208ba401874288548"

// Identifiers
let PHOTO_CELL_IDENTIFIER = "photoCell"
let PIN_ANNOTTATION_IDENTIFIER = "droppablePin"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    
    let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
    
    return url

}


