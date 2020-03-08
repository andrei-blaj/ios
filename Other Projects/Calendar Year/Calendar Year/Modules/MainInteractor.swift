//
//  MainInteractor.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/7/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol {
    
}

class MainInteractor {
    
    var service: MainService
    
    init(service: MainService) {
        self.service = service
    }
    
}

extension MainInteractor: MainInteractorProtocol {
    
}
