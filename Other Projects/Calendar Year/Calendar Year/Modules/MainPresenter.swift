//
//  MainPresenter.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/7/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol {
    
}

class MainPresenter {
    weak var view: MainView?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    init(view: MainView, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
