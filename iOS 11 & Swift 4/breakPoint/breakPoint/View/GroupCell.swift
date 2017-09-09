//
//  GroupCell.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 03/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.membersLbl.text = "\(memberCount) members."
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
