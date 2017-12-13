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
        SessionsNetworkManager.login(email: emailTextField.text!, password: passwordTextField.text!, successHandler: { (id) in
            UsersNetworkManager.getCurrentUser(user_id: Int(id)!, successHandler: { (currentUser) in
                
                self.setUserData(userData: currentUser)
                SessionsNetworkManager.instance.isLoggedIn = true
                
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                
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
    
    func setUserData(userData: [String: Any]) {
        User.instance.id = userData["id"] as! Int
        
        User.instance.email = userData["email"] as! String
        User.instance.first_name = userData["first_name"] as! String
        User.instance.last_name = userData["last_name"] as! String
        User.instance.register_as = userData["register_as"] as! String
        User.instance.company_name = userData["company_name"] as! String
        User.instance.ceo_email = userData["ceo_email"] as! String
        User.instance.manager_email = userData["manager_email"] as! String
        
        User.instance.ceo = userData["ceo"] as! Bool
        User.instance.man = userData["man"] as! Bool
        User.instance.emp = userData["emp"] as! Bool
        User.instance.paid = userData["paid"] as! Bool
        
        User.instance.num_of_managers = userData["num_of_managers"] as! Int
        User.instance.num_of_employees = userData["num_of_employees"] as! Int
        User.instance.company_plan_id = userData["company_plan_id"] as! Int
        
    }
    
}
