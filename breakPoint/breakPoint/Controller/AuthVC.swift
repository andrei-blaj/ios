//
//  AuthVC.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 31/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginByEmailBtnPressed(_ sender: Any) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func googleLoginBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookLoginBtnPressed(_ sender: Any) {
    }
    
    
}
