//
//  MainModuleBuilder.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/7/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import UIKit

class MainModuleBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MainView") as! MainView
        let router = MainRouter(view: view)
        let interactor = MainInteractor(service: MainService.shared)
        let presenter = MainPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
