//
//  TaskInfoVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 29/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TaskInfoVC: UIViewController {

    // Variables
    var taskId = Int()
    var taskDescription = String()
    var taskDeadline = String()
    var firstTime = Bool()
    var working = Bool()
    
    var contributionsForTask: [Int: ContributionInformation] = [:]
    var contributionImages: [Int: Any] = [:]
    var contributionUsers: [Int: String] = [:]
    var contributionUserIds: [Int: Int] = [:]
    
    // Outlets
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskDeadlineLabel: UILabel!
    
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    // Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Refresh Control
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        registerForPreviewing(with: self, sourceView: tableView!)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        working = false
        
        setupView()
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        updateTaskContributions()
    }
    
    func setupView() {
        userInputTextField.text = ""
        sendMessageBtn.isHidden = true
        
        taskDescriptionLabel.font = UIFont.fontAwesome(ofSize: 20)
        taskDescriptionLabel.text = "\(String.fontAwesomeIcon(code: "fa-info-circle")!)  \(taskDescription)"
        
        taskDeadlineLabel.font = UIFont.fontAwesome(ofSize: 18)
        taskDeadlineLabel.text = "\(String.fontAwesomeIcon(code: "fa-calendar")!)  \(taskDeadline)"
        
        tableView.isHidden = true
        
        updateTaskContributions()
        firstTime = false

    }
    
    @IBAction func goBack(sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    @IBAction func onSendBtnPressed(_ sender: Any) {
        view.endEditing(true)
        
        self.sendMessageBtn.isHidden = true
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        let currentDate = Date()
        
        ContributionsNetworkManager.createContribution(userId: Session.shared.currentUser!.id, dailyTaskId: taskId, image: "", content: "\(userInputTextField.text!)", timeStamp: "\(currentDate)") { success in
            if success {

                self.updateTaskContributions()

            } else {
                print("Could not save contribution!")

                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        
        self.userInputTextField.text = ""
        
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
            
            self.contributionsForTask = response
            
            var countImages = 0
            var countUsers = 0
            
            for (key, contribution) in self.contributionsForTask {
                
                if let imagePath = contribution.imagePath {
                    let url = "\(Session.baseUrl())\(imagePath)"
                    Alamofire.request(url).responseImage(completionHandler: { (response) in
                        if response.result.value != nil {
                            let img = response.result.value

                            self.contributionImages[key] = img!

                            countImages += 1
                            if countImages == self.contributionsForTask.count && countUsers == self.contributionsForTask.count {
                                self.afterDownloadReloadData()
                             }
                        }
                    })
                } else {
                    self.contributionImages[key] = ""

                    countImages += 1
                    if countImages == self.contributionsForTask.count && countUsers == self.contributionsForTask.count {
                        self.afterDownloadReloadData()
                    }
                }
                
                UsersNetworkManager.getCurrentUser(user_id: contribution.userId, successHandler: { (response) in
                    
                    let contributer = response
                    let fullName = "\(contributer.firstName) \(contributer.lastName)"
                    let userId = contributer.id
                    
                    self.contributionUsers[key] = fullName
                    self.contributionUserIds[key] = userId
                    
                    countUsers += 1
                    
                    if countImages == self.contributionsForTask.count && countUsers == self.contributionsForTask.count {
                        self.afterDownloadReloadData()
                    }
                    
                }, failureHandler: { (error) in
                    print(error)
                    
                    countUsers += 1
                    
                    if countImages == self.contributionsForTask.count && countUsers == self.contributionsForTask.count {
                        self.afterDownloadReloadData()
                    }
                })

            }
            
        }) { (error) in
            print(error)
            
            self.afterDownloadReloadData()
        }
        
    }
    
    func afterDownloadReloadData() {
        
        tableView.reloadData()
        tableView.isHidden = false
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        refreshControl.endRefreshing()
    }
    
}

extension TaskInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return }
        
        if let image = contributionImages[indexPath.row] as? UIImage {
            popVC.initData(forImage: image)
            present(popVC, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributionsForTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contributionCell", for: indexPath) as? ContributionCell {
            
            let name = self.contributionUsers[indexPath.row]
            let createdAt = self.contributionsForTask[indexPath.row]!.createdAt
            let content = self.contributionsForTask[indexPath.row]!.content
            let img = self.contributionImages[indexPath.row]
            
            cell.configureCell(addedBy: name!, onDate: createdAt, description: content, image: img as Any)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return ContributionCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // If the task is now yet completed and the current user is a MANAGER
        if Session.shared.currentUser!.id == contributionUserIds[indexPath.row] && !working {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Confirm", style: .destructive) { (confirmed) in
            if editingStyle == .delete {
                
                self.startActivityIndicator()
                
                ContributionsNetworkManager.deleteContribution(contributionId: self.contributionsForTask[indexPath.row]!.id, completion: { (deletionSuccessful) in
                    if deletionSuccessful {
                        
                        DailyTasksNetworkManager.getContributionsForDailyTask(withId: self.taskId, successHandler: { (response) in
                            
                            self.contributionsForTask = response
                            
                            self.tableView.beginUpdates()
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.tableView.endUpdates()
                            
                            self.stopActivityIndicator()
                            
                        }, failureHandler: { (error) in
                            print(error)
                            self.stopActivityIndicator()
                        })
                        
                    } else {
                        self.stopActivityIndicator()
                    }
                })
                
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (confirmed) in
            return
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func startActivityIndicator() {
        working = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopActivityIndicator() {
        working = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}

extension TaskInfoVC: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else { return nil }
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return nil }
        
        if let image = contributionImages[indexPath.row] as? UIImage {
            popVC.initData(forImage: image)
        } else {
            return nil
        }
        
        previewingContext.sourceRect = cell.contentView.frame
        
        return popVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }

}



