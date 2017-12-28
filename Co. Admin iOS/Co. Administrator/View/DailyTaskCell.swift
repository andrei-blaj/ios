//
//  DailyTaskCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 27/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class DailyTaskCell: UITableViewCell {
    
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    func configureCell(taskDescription: String, fontAwesomeCode: String) {
        taskDescriptionLabel.font = UIFont.fontAwesome(ofSize: 18)
        taskDescriptionLabel.text = "\(String.fontAwesomeIcon(code: fontAwesomeCode)!)  \(taskDescription)"
    }

}
