//
//  PaymentVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 22/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Stripe

class PaymentVC: UIViewController, STPPaymentCardTextFieldDelegate {

    // Outlets
    @IBOutlet weak var payButtonOutlet: UIButton!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Variables
    var id = Int()
    var amount = Int()
    var packageDescription = String()
    
    // Constants
    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        planLabel.text = packageDescription
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.width - 30, height: 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
        payButtonOutlet.isHidden = true
        
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        if textField.isValid {
            payButtonOutlet.isHidden = false
        }
    }
    
    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPayButtonPressed(_ sender: Any) {
    
        payButtonOutlet.isEnabled = false
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        let card = paymentTextField.cardParams
        
        STPAPIClient.shared().createToken(withCard: card) { (token, error) in
            if let error = error {
                print(error)
            } else if let token = token {
                self.chargeUsingToken(token: token)
            }
        }
        
    }
    
    func chargeUsingToken(token: STPToken) {
        
        PaymentsNetworkManager.pay(token: token, companyPlanId: id) { (completed) in
            if completed {
                // success
                
                let userId = Session.shared.currentUser!.id
                
                UsersNetworkManager.getCurrentUser(user_id: userId, successHandler: { (currentUser) in
                    
                    Session.shared.currentUser = currentUser
                    
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    
                    self.dismiss(animated: true, completion: nil)
                }, failureHandler: { (error) in
                    print(error)
                    
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                // error
                self.errorMessageLabel.isHidden = false
                
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                self.payButtonOutlet.isEnabled = true
            }
        }
        
    }
    
}
