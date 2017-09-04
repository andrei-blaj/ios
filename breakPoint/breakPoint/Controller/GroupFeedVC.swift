//
//  GroupFeedVC.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 04/09/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var textField: InsetTextField!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    // Variables
    var groupMessagesArray = [Message]()
    var group: Group?
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupTitleLbl.text = group?.groupTitle
        
        DataService.instance.getEmails(forGroup: group!) { (returnedEmails) in
            self.groupMembersLbl.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessagesArray) in
                self.groupMessagesArray = returnedGroupMessagesArray
                self.tableView.reloadData()
                
                if self.groupMessagesArray.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessagesArray.count - 1, section: 0), at: .none, animated: true)
                }
                
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendMessageView.bindToKeyboard()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textField.text != "" {
            textField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.textField.text = ""
                    self.textField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        
        let message = groupMessagesArray[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (senderEmail) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: senderEmail, messageContent: message.content)
        }
        
        return cell
    }
    
}
