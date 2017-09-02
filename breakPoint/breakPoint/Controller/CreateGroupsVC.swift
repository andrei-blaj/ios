//
//  CreateGroupsVC.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 02/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var descriptionField: InsetTextField!
    @IBOutlet weak var emailSearchField: InsetTextField!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        // Create group
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
