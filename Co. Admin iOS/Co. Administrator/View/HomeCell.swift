//
//  HomeCell.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 18/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellNumberLabel: UILabel!
    
    @IBOutlet weak var cellFontAwesomeLabel: UILabel!
    
    @IBOutlet weak var linkToBtn: UIButton!
    @IBOutlet weak var arrowBtn: UIButton!
    
    @IBOutlet weak var cellMainView: UIView!
    @IBOutlet weak var cellSecondaryView: UIView!
    
    func configureCell(cellTitle: String, cellNumber: String, cellFontAwesome: String, btnTitle: String, mainViewColor: UIColor, secondaryViewColor: UIColor) {
        cellTitleLabel.text = cellTitle
        
        if cellTitle == "Welcome!" {
            cellNumberLabel.text = ""
        } else {
            cellNumberLabel.text = cellNumber
        }
        
        cellFontAwesomeLabel.font = UIFont.fontAwesome(ofSize: 60)
        cellFontAwesomeLabel.text = String.fontAwesomeIcon(code: cellFontAwesome)
        
        linkToBtn.setTitle(btnTitle, for: .normal)
        arrowBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        cellMainView.backgroundColor = mainViewColor
        cellSecondaryView.backgroundColor = secondaryViewColor
    }
    
}
