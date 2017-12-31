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
    
    var taskId = Int()
    var taskDescription = String()
    var taskDeadline = String()

    var processCount = Int()
    
    var tasks: [Int: TaskInformation] = [:]
    var toDoTasks: [Int: TaskInformation] = [:]
    var completedTasks: [Int: TaskInformation] = [:]
    
    // Outlets
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var projectDeadlineLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Refresh Control
    var refreshControl: UIRefreshControl!
    
    @IBAction func goBack(sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        updateTaskTableViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        processCount = 0
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        projectDescriptionLabel.isHidden = true
        projectDeadlineLabel.isHidden = true
        
        projectTitleLabel.text = projectTitle
        
        tableView.isHidden = true
        
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
            
            self.completedTasks = [:]
            self.toDoTasks = [:]
            
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
        
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
            self.processCount += 1
            
            if self.processCount == 2 {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
            self.refreshControl.endRefreshing()
            
        }) { (error) in
            print(error)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.refreshControl.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let TaskInformationViewController = segue.destination as! TaskInfoVC
        
        TaskInformationViewController.taskId = taskId
        TaskInformationViewController.taskDeadline = taskDeadline
        TaskInformationViewController.taskDescription = taskDescription
    }
    
}

extension ProjectInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if toDoTasks.count > 0 {
                taskId = toDoTasks[indexPath.row]!.id
                taskDescription = toDoTasks[indexPath.row]!.taskDescription
                taskDeadline = toDoTasks[indexPath.row]!.taskDeadline
            } else {
                taskId = completedTasks[indexPath.row]!.id
                taskDescription = completedTasks[indexPath.row]!.taskDescription
                taskDeadline = completedTasks[indexPath.row]!.taskDeadline
            }
        } else {
            taskId = completedTasks[indexPath.row]!.id
            taskDescription = completedTasks[indexPath.row]!.taskDescription
            taskDeadline = completedTasks[indexPath.row]!.taskDeadline
        }
        
        performSegue(withIdentifier: TO_TASK_INFO, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if toDoTasks.count == 0 {
            if completedTasks.count == 0 {
                return nil
            }
            return "Completed"
        } else {
            if completedTasks.count == 0 {
                return "To Do"
            }
            if section == 0 {
                return "To Do"
            } else {
                return "Completed"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if toDoTasks.count == 0 || completedTasks.count == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toDoTasks.count == 0 {
            if completedTasks.count == 0 {
                return 0
            }
            return completedTasks.count
        } else {
            if completedTasks.count == 0 {
                return toDoTasks.count
            }
            if section == 0 {
                return toDoTasks.count
            } else {
                return completedTasks.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dailyTaskCell", for: indexPath) as? DailyTaskCell {
            
            if indexPath.section == 0 {
                // To Do
                if toDoTasks.count == 0 {
                    cell.configureCell(taskDescription: "\(completedTasks[indexPath.row]!.taskDescription)", fontAwesomeCode: "fa-check-square-o")
                } else {
                    cell.configureCell(taskDescription: "\(toDoTasks[indexPath.row]!.taskDescription)", fontAwesomeCode: "fa-square-o")
                }
            } else {
                // Completed
                cell.configureCell(taskDescription: "\(completedTasks[indexPath.row]!.taskDescription)", fontAwesomeCode: "fa-check-square-o")
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return DailyTaskCell()
    }
}
