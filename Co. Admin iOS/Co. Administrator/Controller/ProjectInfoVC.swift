//
//  ProjectInfoVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 27/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ProjectInfoVC: UIViewController {

    // Variables
    var projectId = Int()
    var projectTitle = String()

    var processCount = 0
    
    // Outlets
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var projectDeadlineLabel: UILabel!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    @IBOutlet weak var toDoLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var completedLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Table Views
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var completedTableView: UITableView!
    
    @IBOutlet weak var toDoTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var completedTableViewHeight: NSLayoutConstraint!
    
    var tasks: [Int: TaskInformation] = [:]
    var toDoTasks: [Int: TaskInformation] = [:]
    var completedTasks: [Int: TaskInformation] = [:]
    
    @IBAction func goBack(sender: Any) {
        self.navigationController!.popViewController(animated: true)
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView.isScrollEnabled = true
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        
        completedTableView.delegate = self
        completedTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        toDoTableView.isHidden = true
        completedTableView.isHidden = true
        
        projectDescriptionLabel.isHidden = true
        projectDeadlineLabel.isHidden = true
        toDoLabel.isHidden = true
        completedLabel.isHidden = true
        
        toDoTableViewHeight.constant = 0
        completedTableViewHeight.constant = 0
        
        projectTitleLabel.text = projectTitle
        
        toDoLabel.font = UIFont.fontAwesome(ofSize: 25)
        toDoLabel.text = "\(String.fontAwesomeIcon(code: "fa-tasks")!)  To Do"
        
        completedLabel.font = UIFont.fontAwesome(ofSize: 25)
        completedLabel.text = "\(String.fontAwesomeIcon(code: "fa-tasks")!)  Completed"
        
        ProjectsNetworkManager.getProject(projectId: projectId, successHandler: { (projectInfo) in
            // Add font awesome icons
            self.projectDescriptionLabel.font = UIFont.fontAwesome(ofSize: 18)
            self.projectDescriptionLabel.text = "\(String.fontAwesomeIcon(code: "fa-info-circle")!)  \(projectInfo.description)"
            
            self.projectDeadlineLabel.font = UIFont.fontAwesome(ofSize: 18)
            self.projectDeadlineLabel.text = "\(String.fontAwesomeIcon(code: "fa-calendar")!)  \(projectInfo.deadline)"
            
            self.projectDescriptionLabel.isHidden = false
            self.projectDeadlineLabel.isHidden = false
            
            self.processCount += 1
            
            if self.processCount == 2 {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
        }) { (error) in
            print(error)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        updateTaskTableViews()
        
    }
    
    func updateTaskTableViews() {
        DailyTasksNetworkManager.getDailyTasks(projectId: projectId, successHandler: { (dailyTasks) in
            self.tasks = dailyTasks
            
            var i = 0
            var j = 0
            
            for task in self.tasks.values {
                if task.completed == true {
                    self.completedTasks[i] = task
                    i += 1
                } else {
                    self.toDoTasks[j] = task
                    j += 1
                }
            }
            
            self.toDoTableView.reloadData()
            self.completedTableView.reloadData()
            
            self.toDoTableView.isHidden = false
            self.completedTableView.isHidden = false
            
            if self.completedTasks.count == 0 {
                self.completedTableView.isHidden = true
                self.completedLabel.isHidden = true
                self.completedLabelHeight.constant = 0
            } else {
                self.completedLabel.isHidden = false
            }
            
            switch self.completedTasks.count {
            case 0:
                self.completedTableViewHeight.constant = 0
            case 1:
                self.completedTableViewHeight.constant = 70
            case 2:
                self.completedTableViewHeight.constant = 140
            default:
                self.completedTableViewHeight.constant = 210
            }
            
            if self.toDoTasks.count == 0 {
                self.toDoTableView.isHidden = true
                self.toDoLabel.isHidden = true
                self.toDoLabelHeight.constant = 0
            } else {
                self.toDoLabel.isHidden = false
            }
            
            switch self.toDoTasks.count {
            case 0:
                self.toDoTableViewHeight.constant = 0
            case 1:
                self.toDoTableViewHeight.constant = 70
            case 2:
                self.toDoTableViewHeight.constant = 140
            default:
                self.toDoTableViewHeight.constant = 210
            }
            
            self.processCount += 1
            
            if self.processCount == 2 {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
        }) { (error) in
            print(error)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}

extension ProjectInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            // To Do Table View
            return toDoTasks.count
        } else {
            // Completed Table View
            return completedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dailyTaskCell", for: indexPath) as? DailyTaskCell {
            
            if tableView.tag == 1 {
                // To Do Table View
                cell.configureCell(taskDescription: "\(toDoTasks[indexPath.row]!.taskDescription)", fontAwesomeCode: "fa-square-o")
            } else {
                // Completed Table View
                cell.configureCell(taskDescription: "\(completedTasks[indexPath.row]!.taskDescription)", fontAwesomeCode: "fa-check-square-o")
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return DailyTaskCell()
    }
}
