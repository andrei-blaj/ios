//
//  SideMenuVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(SideMenuVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupUserInfo()
    }

    @IBAction func onLoginBtnPressed(_ sender: Any) {
        if !SessionsNetworkManager.instance.isLoggedIn {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        // update the login btn text with the name of the user
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if SessionsNetworkManager.instance.isLoggedIn {
            loginBtn.setTitle("\(User.instance.first_name)", for: .normal)
        } else {
            loginBtn.setTitle("Login", for: .normal)
        }
    }
    
}
