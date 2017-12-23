//
//  ManagersVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 19/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ManagersVC: UIViewController {

    var employeeName = String()
    var employeeEmail = String()
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var managerList: [Int: employeeInformation] = [:]
    
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
        
        populateManagerList()
    }
    
    func populateManagerList() {
        UsersNetworkManager.getManagers(successHandler: { (response) in
            self.managerList = response
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let EmployeeProfileViewController = segue.destination as! EmployeeProfileVC
        
        EmployeeProfileViewController.employeeName = employeeName
        EmployeeProfileViewController.employeeEmail = employeeEmail
    }

}

extension ManagersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeName = "\(managerList[indexPath.row]!.firstName) \(managerList[indexPath.row]!.lastName)"
        employeeEmail = managerList[indexPath.row]!.email
        
        performSegue(withIdentifier: TO_EMP_INFO, sender: nil)
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
