//
//  Constants.swift
//  PixelCity
//
//  Created by Andrei-Sorin Blaj on 21/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

let API_KEY = "5dd6ff68a529373208ba401874288548"

// Identifiers
let PHOTO_CELL_IDENTIFIER = "photoCell"
let PIN_ANNOTTATION_IDENTIFIER = "droppablePin"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    
    let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
    
    return url

}

// Number of photos to download
let NUMBER_OF_PHOTOS = 36

// Collection View Cell width and height based on the screen size
let CELL_WIDTH = CGFloat(45.0)
let CELL_HEIGHT = CGFloat(50.0)

// The height of the View is 300, the width of the View is screenSize.width
// The way to return the size of a cell in order to fit all 40 cells in the view is:
// multiply 300 by screenSize.width, divide the result by 40 and apply sqrt on that and you get the width of the cell
