//
//  UpgradePlanVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 20/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UpgradePlanVC: UIViewController {

    // Variables
    var id = Int()
    var amount = Int()
    var packageDescription = String()
    
    // Constants
    let amounts = [0: "99", 1: "199", 2: "399"]
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let PaymentViewController = segue.destination as! PaymentVC
        
        PaymentViewController.id = id
        PaymentViewController.amount = amount
        PaymentViewController.packageDescription = packageDescription
    }
    
}

extension UpgradePlanVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        id = companyPlans[indexPath.row]!.id
        amount = companyPlans[indexPath.row]!.price
        packageDescription = companyPlans[indexPath.row]!.plan
        
        performSegue(withIdentifier: TO_PAYMENT, sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let companyPlanId = Session.shared.currentUser!.companyPlanId
        switch companyPlanId {
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "upgradePlanCell", for: indexPath) as? UpgradePlanCell {
            
            let cellHeading = cellHeadings[indexPath.row + 1]
            
            let managerCnt = managers[indexPath.row + 1]
            let employeeCnt = employees[indexPath.row + 1]
            let projectCnt = projects[indexPath.row + 1]
            
            let price = prices[indexPath.row + 1]
            
            cell.configureCell(cellHeading: cellHeading!, managerCount: managerCnt!, employeeCount: employeeCnt!, projectCount: projectCnt!, price: price!)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return UpgradePlanCell()
    }
    
}
