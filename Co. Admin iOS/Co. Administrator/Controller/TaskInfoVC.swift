//
//  TaskInfoVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 29/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class TaskInfoVC: UIViewController {

    // Variables
    var taskId = Int()
    var taskDescription = String()
    var taskDeadline = String()
    
    var contributionsForTask: [Int: ContributionInformation] = [:]
    
    // Outlets
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskDeadlineLabel: UILabel!
    
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    // Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func goBack(sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    @IBAction func onSendBtnPressed(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sendMessageBtn.isHidden = true
        
        taskDescriptionLabel.text = taskDescription
        taskDeadlineLabel.text = taskDeadline
        
        tableView.isHidden = true
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        updateTaskContributions()
        
    }
    
    @IBAction func onTestFieldEdit(_ sender: Any) {
        if userInputTextField.text == "" {
            sendMessageBtn.isHidden = true
        } else {
            sendMessageBtn.isHidden = false
        }
    }
    
    func updateTaskContributions() {
        DailyTasksNetworkManager.getContributionsForDailyTask(withId: taskId, successHandler: { (response) in
            print(response)
            
            
            
            
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }) { (error) in
            print(error)
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension TaskInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
