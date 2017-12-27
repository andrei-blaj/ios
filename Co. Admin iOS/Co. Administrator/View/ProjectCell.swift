//
//  ProjectCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 25/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var fontAwesomeLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDeadlineLabel: UILabel!
    @IBOutlet weak var projectPercentageLabel: UILabel!
    @IBOutlet weak var fontAwesomeDeadlineLabel: UILabel!
    
    func configureCell(projectName: String, projectDeadline: String, completed: Bool) {
        
        fontAwesomeLabel.font = UIFont.fontAwesome(ofSize: 30)
        fontAwesomeLabel.text = String.fontAwesomeIcon(code: "fa-folder-open")
        
        fontAwesomeDeadlineLabel.font = UIFont.fontAwesome(ofSize: 20)
        fontAwesomeDeadlineLabel.text = String.fontAwesomeIcon(code: "fa-calendar")
        
        projectNameLabel.text = projectName
        projectDeadlineLabel.text = projectDeadline
    
        projectPercentageLabel.font = UIFont.fontAwesome(ofSize: 20)
        projectPercentageLabel.clipsToBounds = true
        projectPercentageLabel.layer.cornerRadius = 20
        
        if completed == true {
            projectPercentageLabel.layer.backgroundColor = #colorLiteral(red: 0.1596993208, green: 0.6567096114, blue: 0.2737214267, alpha: 1)
            projectPercentageLabel.text = String.fontAwesomeIcon(code: "fa-check")
        } else {
            projectPercentageLabel.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            projectPercentageLabel.text = String.fontAwesomeIcon(code: "fa-check")
        }
        
    }

}
