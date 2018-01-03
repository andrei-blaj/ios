//
//  ManagersVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 19/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ManagersVC: UIViewController {

    // Variables
    var employeeBackgroundColor = UIColor()
    var employeeName = String()
    var employeeEmail = String()
    var employeeStatus = String()
    var employeeId = Int()
    
    // Outlets
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var notificationBubbleLabel: UILabel!
    
    var managerList: [Int: employeeInformation] = [:]
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        tableView.isHidden = true
        
        populateManagerList()
        showNotifications()
    }
    
    func showNotifications() {
        // If there are any new project notification for the current user then the bubble will be displayed, otherwise .isHidden = true
        
        notificationBubbleLabel.isHidden = true
        notificationBubbleLabel.font = UIFont.fontAwesome(ofSize: 17)
        notificationBubbleLabel.text = String.fontAwesomeIcon(code: "fa-circle")
        
        NotificationsNetworkManager.getNotifications(notificationType: "new_man", successHandler: { (notifCount) in
            if notifCount > 0 {
                self.notificationBubbleLabel.isHidden = false
            }
        }) { (error) in
            print(error)
        }
        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        populateManagerList()
        showNotifications()
    }
    
    func populateManagerList() {
        if Session.shared.isLoggedIn() {
            UsersNetworkManager.getManagers(successHandler: { (response) in
                self.managerList = response
                
                self.tableView.reloadData()
                self.tableView.isHidden = false
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                self.refreshControl.endRefreshing()
            }) { (error) in
                print(error)
                
                self.refreshControl.endRefreshing()
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let EmployeeProfileViewController = segue.destination as! EmployeeProfileVC
        
        EmployeeProfileViewController.employeeName = employeeName
        EmployeeProfileViewController.employeeEmail = employeeEmail
        EmployeeProfileViewController.employeeStatus = employeeStatus
        EmployeeProfileViewController.employeeBackgroundColor = employeeBackgroundColor
        EmployeeProfileViewController.employeeId = employeeId
    }

}

extension ManagersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeName = "\(managerList[indexPath.row]!.firstName) \(managerList[indexPath.row]!.lastName)"
        employeeEmail = managerList[indexPath.row]!.email
        employeeStatus = "Manager"
        employeeBackgroundColor = #colorLiteral(red: 0.1605996788, green: 0.6530888677, blue: 0.2737731636, alpha: 1)
        employeeId = managerList[indexPath.row]!.id
        
        performSegue(withIdentifier: TO_MAN_INFO, sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as? EmployeeCell {
            
            let name = "\(managerList[indexPath.row]!.firstName) \(managerList[indexPath.row]!.lastName)"
            let email = managerList[indexPath.row]?.email
            
            cell.configureCell(name: name, email: email!)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return EmployeeCell()
    }
    
}
