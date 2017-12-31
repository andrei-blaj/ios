//
//  ContributionCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 30/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ContributionCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var addedByLabel: UILabel!
    @IBOutlet weak var contributionDescriptionLabel: UILabel!
    @IBOutlet weak var contributionImageView: UIImageView!
    
    func configureCell(addedBy: String, onDate: String, description: String, image: Any) {
        
        contributionImageView.layer.cornerRadius = 30
        
        addedByLabel.text = "Added by \(addedBy)"
        contributionDescriptionLabel.text = description
        if let img = image as? UIImage {
            self.contributionImageView.image = img
        } else {
            contributionImageView.isHidden = true
        }
        
//        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
//        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ss.SSSSxxx"
//
//        let date = dateFormatter.date(from: onDate)
//        let calendar = Calendar.current
//
//        let year = calendar.component(.year, from: date!)
//        let month = calendar.component(.month, from: date!)
//        let day = calendar.component(.day, from: date!)
        
    }

}
