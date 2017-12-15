//
//  SideMenuVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var companyPlanLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        setupViewData()
    }

    @IBAction func onLoginBtnPressed(_ sender: Any) {
        if Session.shared.isLoggedIn() {
            performSegue(withIdentifier: TO_USER_DETAILS, sender: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    func setupViewData() {
        if Session.shared.isLoggedIn() {
            loginBtn.setTitle("\(Session.shared.currentUser!.firstName)", for: .normal)
            companyNameLabel.text = "\(Session.shared.currentUser!.companyName)"
            companyPlanLabel.text = companyPlan[Session.shared.currentUser!.companyPlanId]
        } else {
            loginBtn.setTitle("Login", for: .normal)
            companyNameLabel.text = "Welcome"
            companyPlanLabel.text = ""
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
                return 5
            } else if Session.shared.currentUser!.man {
                return 3
            } else {
                return 2
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
            } else if Session.shared.currentUser!.emp {
                title = empMenuElements[indexPath.row + 1]
                icon = empMenuIcons[indexPath.row + 1]
            }
            
            cell.configureCell(menuElementTitle: title!, menuIconName: icon!)
            
            return cell
        }
        return SideMenuCell()
    }
    
}
