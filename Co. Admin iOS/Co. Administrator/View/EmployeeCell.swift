//
//  EmployeeCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 23/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var fontAwesomeLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeEmailLabel: UILabel!
    
    func configureCell(name: String, email: String) {
        
        fontAwesomeLabel.clipsToBounds = true
        fontAwesomeLabel.layer.cornerRadius = 20
        
        fontAwesomeLabel.font = UIFont.fontAwesome(ofSize: 30)
        fontAwesomeLabel.text = String.fontAwesomeIcon(code: "fa-user")
        
        employeeNameLabel.text = name
        employeeEmailLabel.text = email
        
    }

}
