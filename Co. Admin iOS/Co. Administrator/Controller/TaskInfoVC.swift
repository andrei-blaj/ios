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
    
    var contributionsForTask: [Int: ContributionInformation] = [:]
    var contributionImages: [Int: Any] = [:]
    var contributionUsers: [Int: String] = [:]
    
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
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        registerForPreviewing(with: self, sourceView: tableView!)
        
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
        
        taskDescriptionLabel.font = UIFont.fontAwesome(ofSize: 20)
        taskDescriptionLabel.text = "\(String.fontAwesomeIcon(code: "fa-info-circle")!)  \(taskDescription)"
        
        taskDeadlineLabel.font = UIFont.fontAwesome(ofSize: 18)
        taskDeadlineLabel.text = "\(String.fontAwesomeIcon(code: "fa-calendar")!)  \(taskDeadline)"
        
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
            
            self.contributionsForTask = response
            
            var countImages = 0
            
            for (key, contribution) in self.contributionsForTask {
                
                if let imagePath = contribution.imagePath {
                    let url = "\(Session.baseUrl())\(imagePath)"
                    Alamofire.request(url).responseImage(completionHandler: { (response) in
                        if response.result.value != nil {
                            let img = response.result.value

                            self.contributionImages[key] = img!

                            countImages += 1
                            if countImages == self.contributionsForTask.count {
                                self.tableView.reloadData()
                                self.tableView.isHidden = false
                                
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                             }
                        }
                    })
                } else {
                    self.contributionImages[key] = ""

                    countImages += 1
                    if countImages == self.contributionsForTask.count {
                        self.tableView.reloadData()
                        self.tableView.isHidden = false
                        
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
                }

            }
  
        }) { (error) in
            print(error)
            
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
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
            
            let name = ""
            let createdAt = self.contributionsForTask[indexPath.row]!.createdAt
            let content = self.contributionsForTask[indexPath.row]!.content
            let img = self.contributionImages[indexPath.row]
            
            cell.configureCell(addedBy: name, onDate: createdAt, description: content, image: img as Any)
//
//            UsersNetworkManager.getCurrentUser(user_id: contributionsForTask[indexPath.row]!.userId, successHandler: { (response) in
//
//                let name = "\(response.firstName) \(response.lastName)"
//                let createdAt = self.contributionsForTask[indexPath.row]!.createdAt
//                let content = self.contributionsForTask[indexPath.row]!.content
////                let img = self.contributionImages[self.contributionsForTask.count - indexPath.row - 1]!
//                let img = ""
//
//                cell.configureCell(addedBy: name, onDate: createdAt, description: content, image: img)
//            }, failureHandler: { (error) in
//                print(error)
//            })
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return ContributionCell()
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



