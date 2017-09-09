//
//  MessageCell.swift
//  Smack
//
//  Created by Andrei-Sorin Blaj on 17/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
}

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
    
        // 2017-08-17T21:52:29.367Z
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        
        // 2017-08-17T21:52:29
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        // 2017-08-17T21:52:29Z
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
        
//        let timeStampText = convertTimeStampToTemplate(string: isoDate)
//        timeStampLbl.text = timeStampText

    }
    
    // Function that I've written for converting the API timestamp to readable date
    // Takes in an ISODate provied by the api and returns a different format
    // Example: "2017-08-17T21:52:29.367Z" -> "Aug 17, 9:52 PM"
    func convertTimeStampToTemplate(string: String) -> String {
        
        // "2017-08-17T21:52:29.367Z" -> "Aug 17, 9:52 PM"
        
        let months: [String: String] = [
            "1":"Jan", "2":"Feb", "3":"Mar", "4":"Apr", "5":"May", "6":"Jun", "7":"Jul", "8":"Aug", "9":"Sep", "10":"Oct", "11":"Nov", "12":"Dec"
        ]
        
        var i = 0, month = "", day = "", hour = "", minute = "", period = "AM"
        
        while string[i] != "-" { i += 1 }
        
        i += 1
        
        while string[i] != "-" {
            if month == "" && string[i] == "0" { i += 1; continue } // Skipping the 0s at the beginning of the month
            month = "\(month)" + string[i]
            i += 1
        }
        
        i += 1
        
        while string[i] != "T" {
            if day == "" && string[i] == "0" { i += 1; continue } // Skipping the 0s at the beginning of the day
            day = "\(day)" + string[i]
            i += 1
        }
        
        i += 1
        
        while string[i] != ":" { hour = hour + string[i]; i += 1 }
        
        i += 1
        
        while string[i] != ":" { minute = minute + string[i]; i += 1 }
        
        if hour > "11" { period = "PM" }
        
        guard let m = months[month] else { return "" }
        
        if hour == "00" { hour = "12" }
        
        let result = m + " " + day + ", " + hour + ":" + minute + " " + period
        
        return result
    }
    
}
