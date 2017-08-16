//
//  LoginVC.swift
//  Smack
//
//  Created by Andrei-Sorin Blaj on 09/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        self.errorLabel.isHidden = true
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                })
            
            } else {
                // In case the user infomation is not valid
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
                self.errorLabel.text = "Inexistent Account!"
                self.errorLabel.isHidden = false
            }
        }
    
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setupView() {
        
        spinner.isHidden = true
        errorLabel.isHidden = true
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap))
        view.addGestureRecognizer(tap)
    
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
}
