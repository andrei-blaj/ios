//
//  MainVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        if Session.shared.isLoggedIn() {
            companyNameLabel.text = "Home"
        } else {
            companyNameLabel.text = "Co. Administrator"
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
}
