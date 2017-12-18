//
//  MainVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        if Session.shared.isLoggedIn() {
            companyNameLabel.text = "Home"
        } else {
            companyNameLabel.text = "Co. Administrator"
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Session.shared.isLoggedIn() {
            if Session.shared.currentUser!.ceo {
                return 4
            } else if Session.shared.currentUser!.man {
                return 3
            } else {
                return 2
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell {
            
            // Still need to add the SEGUE identifier for performing segues when tapping button
            // Will modify when I'll create the views
            
            let title = homeTableViewCellTitles[indexPath.row + 1]
            let number = "\(1)"
            let icon = homeTableViewCellIcons[indexPath.row + 1]
            
            let btnTitle = homeTableViewCellButtonTitle[indexPath.row + 1]
            let mainViewColor = homeTableViewCellMainViewColor[indexPath.row + 1]
            let secondaryViewColor = homeTableViewCellSecondaryViewColor[indexPath.row + 1]
            
            cell.configureCell(cellTitle: title!, cellNumber: number, cellFontAwesome: icon!, btnTitle: btnTitle!, mainViewColor: mainViewColor!, secondaryViewColor: secondaryViewColor!)
            
            return cell
        }
        
        return HomeCell()
    }
    
}
