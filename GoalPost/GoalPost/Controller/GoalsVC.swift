//
//  ViewController.swift
//  GoalPost
//
//  Created by Andrei-Sorin Blaj on 23/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetch { (success) in
            if success {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
        
        tableView.reloadData()
        
    }

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
        
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        
        return cell
        
    }
    
}

extension GoalsVC {
    
    func fetch(completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}





























