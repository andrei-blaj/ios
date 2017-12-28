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
        
        setupTextFieldBorderColor()
    }
    
    func setupTextFieldBorderColor() {
        let borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        emailTextField.layer.borderColor = borderColor.cgColor
        passwordTextField.layer.borderColor = borderColor.cgColor
        
        emailTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
    }
    
    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        SessionsNetworkManager.login(email: emailTextField.text!, password: passwordTextField.text!, successHandler: { (id, authToken) in
            UsersNetworkManager.getCurrentUser(user_id: Int(id), successHandler: { (currentUser) in

                Session.shared.currentUser = currentUser
                
                if Session.shared.isLoggedIn() {
                    self.save(completion: { (saveSuccessful) in
                        if saveSuccessful {
                            self.dismiss(animated: true, completion: nil)
                        } // otherwise error print message from the save method will be saved
                    })
                }
                
            }, failureHandler: { (error) in
                print(error)
            })
        }) { (error) in
            print(error)
        }
    }

    @IBAction func onRegistrationBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_REGISTRATION, sender: nil)
    }
    
    @IBAction func onBackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


// Core Data
extension LoginVC {
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return } // still need to figure this out
        let savedUser = SavedUserData(context: managedContext)
        
        savedUser.user_id = Int16((Session.shared.currentUser?.id)!)
        savedUser.auth_token = Session.shared.authToken
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}
