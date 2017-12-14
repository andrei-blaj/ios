//
//  SideMenuVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.reloadData()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
        setupUserInfo()
    }

    @IBAction func onLoginBtnPressed(_ sender: Any) {
        if !Session.shared.isLoggedIn() {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    func setupUserInfo() {
        if Session.shared.isLoggedIn() {
            loginBtn.setTitle("\(Session.shared.currentUser!.firstName)", for: .normal)
            companyNameLabel.text = "\(Session.shared.currentUser!.companyName)"
        } else {
            loginBtn.setTitle("Login", for: .normal)
            companyNameLabel.text = "Welcome"
        }
    }
    
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Session.shared.isLoggedIn() {
            if Session.shared.currentUser!.ceo {
                return 6
            } else if Session.shared.currentUser!.man {
                return 4
            } else {
                return 3
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as? SideMenuCell {
            
            var title = ceoMenuElements[indexPath.row + 1]
            var icon = ceoMenuIcons[indexPath.row + 1]
            
            if Session.shared.currentUser!.man {
                title = manMenuElements[indexPath.row + 1]
                icon = manMenuIcons[indexPath.row + 1]
            } else {
                title = empMenuElements[indexPath.row + 1]
                icon = empMenuIcons[indexPath.row + 1]
            }
            
            cell.configureCell(menuElementTitle: title!, menuIconName: icon!)
            
            return cell
        }
        return SideMenuCell()
    }
    
}
