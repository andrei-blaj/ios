//
//  GroupFeedCell.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 04/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, messageContent: String) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.messageContentLbl.text = messageContent
    }
    
}
