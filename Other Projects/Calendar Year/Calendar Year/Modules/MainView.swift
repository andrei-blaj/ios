//
//  MainView.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/7/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import UIKit

protocol MainViewProtocol {
    
}

class MainView: UIViewController {

    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

extension MainView: MainViewProtocol {
    
}
