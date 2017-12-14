//
//  LoginVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 09/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        SessionsNetworkManager.login(email: emailTextField.text!, password: passwordTextField.text!, successHandler: { (id, authToken) in
            UsersNetworkManager.getCurrentUser(user_id: Int(id)!, successHandler: { (currentUser) in

                Session.shared.currentUser = currentUser
                
                self.dismiss(animated: true, completion: nil)
            }, failureHandler: { (error) in
                print(error)
            })
        }) { (error) in
            print(error)
        }
    }

    @IBAction func onBackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
