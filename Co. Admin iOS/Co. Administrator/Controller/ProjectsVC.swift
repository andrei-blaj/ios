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
    
    func populateProjectsList() {
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
    }

}

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
        if editingStyle == .delete {
            startDeletionActivityIndicator()
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
