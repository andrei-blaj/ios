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

    @IBOutlet weak var menuElement: UIButton!
    @IBOutlet weak var menuIcon: UILabel!
    
    func configureCell(menuElementTitle: String, menuIconName: String) {
        menuElement.setTitle(menuElementTitle, for: .normal)
        menuIcon.font = UIFont.fontAwesome(ofSize: 25)
        menuIcon.text = String.fontAwesomeIcon(code: menuIconName)
    }

}
