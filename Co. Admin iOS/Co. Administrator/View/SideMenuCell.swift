//
//  SideMenuCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 14/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SideMenuCell: UITableViewCell {

    var delegate: HomeCellDelegator!
    
    @IBOutlet weak var menuElement: UIButton!
    @IBOutlet weak var menuIcon: UILabel!
    
    var segueIdentifier: String!
    
    func configureCell(index: Int, menuElementTitle: String, menuIconName: String) {
        menuElement.setTitle(menuElementTitle, for: .normal)
        menuIcon.font = UIFont.fontAwesome(ofSize: 25)
        menuIcon.text = String.fontAwesomeIcon(code: menuIconName)
        
        if Session.shared.isLoggedIn() {
            if (Session.shared.currentUser?.ceo)! {
                segueIdentifier = ceoSegues[index]
            } else if (Session.shared.currentUser?.man)! {
                segueIdentifier = manSegues[index]
            } else {
                segueIdentifier = empSegues[index]
            }
        }
    }
    
    @IBAction func onSideMenuElementPressed(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.callSegueForHomeCell(withIdentifier: segueIdentifier!)
        }
    }

}
