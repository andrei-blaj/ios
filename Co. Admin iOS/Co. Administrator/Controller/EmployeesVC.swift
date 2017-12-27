//
//  EmployeesVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 19/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class EmployeesVC: UIViewController {

    var employeeBackgroundColor = UIColor()
    var employeeName = String()
    var employeeEmail = String()
    var employeeStatus = String()
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var employeeList: [Int: employeeInformation] = [:]
    
    var refreshControl: UIRefreshControl!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = UIStoryBoardUnwindSegueFromRight(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        populateEmployeeList()
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        populateEmployeeList()
    }
    
    func populateEmployeeList() {
        UsersNetworkManager.getEmployeesForCeo(successHandler: { (response) in
            self.employeeList = response
            
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.refreshControl.endRefreshing()
        }) { (error) in
            print(error)
            
            self.refreshControl.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let EmployeeProfileViewController = segue.destination as! EmployeeProfileVC
        
        EmployeeProfileViewController.employeeName = employeeName
        EmployeeProfileViewController.employeeEmail = employeeEmail
        EmployeeProfileViewController.employeeStatus = employeeStatus
        EmployeeProfileViewController.employeeBackgroundColor = employeeBackgroundColor
    }
    
}

extension EmployeesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeName = "\(employeeList[indexPath.row]!.firstName) \(employeeList[indexPath.row]!.lastName)"
        employeeEmail = employeeList[indexPath.row]!.email
        employeeStatus = "Employee"
        employeeBackgroundColor = #colorLiteral(red: 0.8633926511, green: 0.2097119093, blue: 0.2702368498, alpha: 1)
        
        performSegue(withIdentifier: TO_EMP_INFO, sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as? EmployeeCell {
            
            let name = "\(employeeList[indexPath.row]!.firstName) \(employeeList[indexPath.row]!.lastName)"
            let email = employeeList[indexPath.row]?.email
            
            cell.configureCell(name: name, email: email!)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return EmployeeCell()
    }
    
    
}

