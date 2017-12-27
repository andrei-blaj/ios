//
//  EmployeeProfileVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 23/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class EmployeeProfileVC: UIViewController {

    var employeeBackgroundColor = UIColor()
    var employeeName = String()
    var employeeEmail = String()
    var employeeProjectCount = Int()
    var employeeStatus = String()
    
    @IBOutlet weak var employeeFontAwesomeLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeEmailLabel: UILabel!
    @IBOutlet weak var employeeProjectsLabel: UILabel!
    @IBOutlet weak var employeeStatusLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
        
    var employeeList: [Int: employeeInformation] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if employeeStatus == "Manager" {
            populateEmployeeList()
        } else {
            tableView.isHidden = true
            setupView()
        }
    }
    
    func setupView() {
        
        employeeFontAwesomeLabel.backgroundColor = employeeBackgroundColor
        employeeFontAwesomeLabel.layer.cornerRadius = 35
        employeeFontAwesomeLabel.clipsToBounds = true
        employeeFontAwesomeLabel.font = UIFont.fontAwesome(ofSize: 60)
        employeeFontAwesomeLabel.text = String.fontAwesomeIcon(code: "fa-user")
        
        employeeNameLabel.text = employeeName
        employeeEmailLabel.text = employeeEmail
        employeeStatusLabel.text = employeeStatus
        
        if employeeStatus == "Manager" {
            ProjectsNetworkManager.getProjectCount(userEmail: employeeEmail, successHandler: { (response) in
                self.employeeProjectCount = response
                
                if self.employeeProjectCount == 0 {
                    if self.employeeList.count == 0 {
                        self.employeeProjectsLabel.text = "No projects assigned."
                    } else {
                        self.employeeProjectsLabel.text = "Responsible for"
                    }
                } else if self.employeeProjectCount == 1 {
                    if self.employeeList.count == 0 {
                        self.employeeProjectsLabel.text = "In charge of 1 project."
                    } else {
                        self.employeeProjectsLabel.text = "In charge of 1 project.\n Responsible for"
                    }
                } else {
                    if self.employeeList.count == 0 {
                        self.employeeProjectsLabel.text = "In charge of \(self.employeeProjectCount) projects."
                    } else {
                        self.employeeProjectsLabel.text = "In charge of \(self.employeeProjectCount) projects.\n Responsible for"
                    }
                }
                
            }) { (error) in
                print(error)
            }
        } else {
            UsersNetworkManager.getSuperiorForEmp(employeeEmail: employeeEmail, successHandler: { (superior) in
                self.employeeProjectsLabel.text = "Supervised by \(superior["first_name"]!) \(superior["last_name"]!) \n \(superior["email"]!)"
            }, failureHandler: { (error) in
                print(error)
            })
        }
        
    }
    
    func populateEmployeeList() {
        UsersNetworkManager.getEmployeesForMan(managerEmail: employeeEmail, successHandler: { (response) in
            self.employeeList = response
            self.tableView.reloadData()
            
            self.setupView()
        }) { (error) in
            print(error)
        }
    }
    
}

extension EmployeeProfileVC: UITableViewDelegate, UITableViewDataSource {
    
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
