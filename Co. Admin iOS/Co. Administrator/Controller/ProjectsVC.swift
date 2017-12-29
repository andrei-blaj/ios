//
//  ProjectsVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 18/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class ProjectsVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var delectionActivityIndicator: UIActivityIndicatorView!
    
    var projects: [Int: ProjectInformation] = [:]
    
    var projectId = Int()
    var projectTitle = String()
    
    var refreshControl: UIRefreshControl!
    var working: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.isHidden = true
        startDeletionActivityIndicator()
        populateProjectsList()
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        populateProjectsList()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    func populateProjectsList() {
        if Session.shared.isLoggedIn() {
            ProjectsNetworkManager.getProjects(successHandler: { (response) in
                self.projects = response
        
                self.tableView.reloadData()
                self.tableView.isHidden = false
        
                self.stopDeletionActivityIndicator()
        
                self.refreshControl.endRefreshing()
            }) { (error) in
                print(error)
                
                self.refreshControl.endRefreshing()
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ProjectInfoViewController = segue.destination as! ProjectInfoVC
        
        ProjectInfoViewController.projectId = projectId
        ProjectInfoViewController.projectTitle = projectTitle
    }
    
}

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        projectId = projects[indexPath.row]!.id
        projectTitle = "\(projects[indexPath.row]!.name)"
        
        performSegue(withIdentifier: TO_PROJ_INFO, sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectCell {
            
            let name = "\(projects[indexPath.row]!.name)"
            let deadline = "\(projects[indexPath.row]!.deadline)"
            let completed = projects[indexPath.row]!.completed
            
            cell.configureCell(projectName: name, projectDeadline: deadline, completed: completed)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return ProjectCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if Session.shared.currentUser!.ceo == true && working == false {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Confirm", style: .destructive) { (confirmed) in
            if editingStyle == .delete {
                self.startDeletionActivityIndicator()
                ProjectsNetworkManager.delete(projectId: self.projects[indexPath.row]!.id, completion: { (deletionSuccessful) in
                    if deletionSuccessful {
                        
                        ProjectsNetworkManager.getProjects(successHandler: { (response) in
                            self.projects = response
                            
                            self.tableView.beginUpdates()
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.tableView.endUpdates()
                            
                            self.stopDeletionActivityIndicator()
                            
                        }) { (error) in
                            print(error)
                            self.stopDeletionActivityIndicator()
                        }
                    } else {
                        self.stopDeletionActivityIndicator()
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
    
    func startDeletionActivityIndicator() {
        working = true
        delectionActivityIndicator.startAnimating()
        delectionActivityIndicator.isHidden = false
    }
    
    func stopDeletionActivityIndicator() {
        working = false
        delectionActivityIndicator.isHidden = true
        delectionActivityIndicator.stopAnimating()
    }
}
