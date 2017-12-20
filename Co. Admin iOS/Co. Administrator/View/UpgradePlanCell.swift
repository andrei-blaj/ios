//
//  UpgradePlanCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 20/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UpgradePlanCell: UITableViewCell {

    
    @IBOutlet weak var cellHeadingLabel: UILabel!
    
    @IBOutlet weak var managersLabel: UILabel!
    @IBOutlet weak var employeesLabel: UILabel!
    @IBOutlet weak var projectsLabel: UILabel!
    
    @IBOutlet weak var priceBtn: UIButton!
    
    func configureCell(cellHeading: String, managerCount: String, employeeCount: String, projectCount: String, price: String) {
        cellHeadingLabel.text = cellHeading
        
        managersLabel.text = managerCount
        employeesLabel.text = employeeCount
        projectsLabel.text = projectCount
        
        priceBtn.setTitle(price, for: .normal)
    }
    
}
