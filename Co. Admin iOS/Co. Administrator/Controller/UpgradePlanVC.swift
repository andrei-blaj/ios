//
//  UpgradePlanVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 20/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class UpgradePlanVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }

    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension UpgradePlanVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
