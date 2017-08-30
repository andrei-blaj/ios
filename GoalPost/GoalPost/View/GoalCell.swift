//
//  GoalCell.swift
//  GoalPost
//
//  Created by Andrei-Sorin Blaj on 27/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(goal: Goal) {
        
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
    
    }

}
