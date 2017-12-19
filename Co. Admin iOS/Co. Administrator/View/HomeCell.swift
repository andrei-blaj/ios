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
    
    func configureCell(index: Int, cellTitle: String, cellNumber: String, cellFontAwesome: String, btnTitle: String, mainViewColor: UIColor, secondaryViewColor: UIColor) {
        
        // Setting the 'cellTitleLabel' & 'cellNumberLabel'
        switch index {
        case 1:
            cellTitleLabel.text = cellTitle
            cellNumberLabel.text = ""
        case 2:
            ProjectsNetworkManager.getProjectCount(successHandler: { (project_count) in
                if project_count == 0 {
                    self.cellTitleLabel.text = "No projects"
                    self.cellNumberLabel.text = ""
                } else {
                    self.cellTitleLabel.text = cellTitle
                    self.cellNumberLabel.text = "\(project_count)"
                }
            }, failureHandler: { (error) in
                print(error)
                self.cellTitleLabel.text = "No projects"
                self.cellNumberLabel.text = ""
            })
        case 3:
            if (Session.shared.currentUser?.ceo)! {
                UsersNetworkManager.getEmployeeCountForCeo(successHandler: { (employee_count) in
                    if employee_count == 0 {
                        self.cellTitleLabel.text = "No employees"
                        self.cellNumberLabel.text = ""
                    } else {
                        self.cellTitleLabel.text = cellTitle
                        self.cellNumberLabel.text = "\(employee_count)"
                    }
                }, failureHandler: { (error) in
                    print(error)
                    self.cellTitleLabel.text = "No employees"
                    self.cellNumberLabel.text = ""
                })
            } else {
                // The user is a manager
                UsersNetworkManager.getEmployeeCountForMan(successHandler: { (employee_count) in
                    if employee_count == 0 {
                        self.cellTitleLabel.text = "No employees"
                        self.cellNumberLabel.text = ""
                    } else {
                        self.cellTitleLabel.text = cellTitle
                        self.cellNumberLabel.text = "\(employee_count)"
                    }
                }, failureHandler: { (error) in
                    print(error)
                    self.cellTitleLabel.text = "No employees"
                    self.cellNumberLabel.text = ""
                })
            }
        case 4:
            UsersNetworkManager.getManagerCount(successHandler: { (manager_count) in
                if manager_count == 0 {
                    self.cellTitleLabel.text = "No managers"
                    self.cellNumberLabel.text = ""
                } else {
                    self.cellTitleLabel.text = cellTitle
                    self.cellNumberLabel.text = "\(manager_count)"
                }
            }, failureHandler: { (error) in
                print(error)
                self.cellTitleLabel.text = "No manager"
                self.cellNumberLabel.text = ""
            })
        default:
            return
        }
        
        cellFontAwesomeLabel.font = UIFont.fontAwesome(ofSize: 60)
        cellFontAwesomeLabel.text = String.fontAwesomeIcon(code: cellFontAwesome)
        
        if index == 1 {
            if Session.shared.isLoggedIn() {
                linkToBtn.setTitle("Enjoy Company Administrator", for: .normal)
            } else {
                linkToBtn.setTitle("Please log in", for: .normal)
            }
            linkToBtn.isEnabled = false
            arrowBtn.isHidden = true
        } else {
            linkToBtn.setTitle(btnTitle, for: .normal)
            arrowBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        linkToBtn.isEnabled = false
        arrowBtn.isEnabled = false
        
        cellMainView.backgroundColor = mainViewColor
        cellSecondaryView.backgroundColor = secondaryViewColor
    }

}
