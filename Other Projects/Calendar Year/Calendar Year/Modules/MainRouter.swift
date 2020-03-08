//
//  MainRouter.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/7/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
    
}

class MainRouter {
    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension MainRouter: MainRouterProtocol {
    
}
