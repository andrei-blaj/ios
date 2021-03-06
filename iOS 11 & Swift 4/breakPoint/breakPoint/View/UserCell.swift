//
//  UserCell.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 02/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    // Variables
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        
        self.profileImage.image = image
        self.emailLbl.text = email
        
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            if self.checkImage.isHidden {
                self.checkImage.isHidden = false
            } else {
                self.checkImage.isHidden = true
            }
        }
        
    }

}
