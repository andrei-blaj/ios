//
//  UserDetailsVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 15/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {

    @IBOutlet weak var upgradePlanBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        upgradePlanBtn.isHidden = true
        
        if Session.shared.isLoggedIn() {
            if Session.shared.currentUser!.ceo && Session.shared.currentUser!.companyPlanId != 4 {
                upgradePlanBtn.isHidden = false
            }
        }
    }

    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutBtnPressed(_ sender: Any) {
        self.removeSavedUser()
        Session.shared.logout()
        
        Session.shared.logoutProtocol = false
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpgradePlanBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_UPGRADE_PLAN, sender: nil)
    }
    
}

extension UserDetailsVC {
    func removeSavedUser() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(Session.shared.savedUserData[0])
        
        do {
            try managedContext.save()
            print("Removal successful!")
        } catch {
            print("Could not save: \(error.localizedDescription)")
        }
    }
}
