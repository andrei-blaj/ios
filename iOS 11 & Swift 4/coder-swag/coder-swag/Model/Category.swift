//
//  Category.swift
//  coder-swag
//
//  Created by Andrei-Sorin Blaj on 01/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

struct Category {
    // Variables are private for setting but public for retrieving
    private(set) public var title: String
    private(set) public var imageName: String

    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
}
