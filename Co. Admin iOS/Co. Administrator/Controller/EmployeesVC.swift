//
//  EmployeesVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 19/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class EmployeesVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var employeeList: [Int: employeeInformation] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        populateEmployeeList()
    }
    
    func populateEmployeeList() {
        UsersNetworkManager.getEmployeesForCeo(successHandler: { (response) in
            self.employeeList = response
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
}

extension EmployeesVC: UITableViewDataSource, UITableViewDelegate {
    
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

