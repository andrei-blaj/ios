//
//  UserDetailsVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 15/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutBtnPressed(_ sender: Any) {
        Session.shared.logout()
        self.removeSavedUser()
        dismiss(animated: true, completion: nil)
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
