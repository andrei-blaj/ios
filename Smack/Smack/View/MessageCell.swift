//
//  MessageCell.swift
//  Smack
//
//  Created by Andrei-Sorin Blaj on 17/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    
        
    }
    
}
