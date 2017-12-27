//
//  MainVC.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 08/11/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MainVC: UIViewController {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
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
        
        tableView.reloadData()
        
        updateUserData()
        
        if Session.shared.isLoggedIn() {
            companyNameLabel.text = "Home"
        } else {
            companyNameLabel.text = "Co. Administrator"
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        updateUserData()
    }
}

extension MainVC {
    
    // Load data from core data
    func updateUserData() {
        self.fetchUserData { (fetchSuccessful) in
            if fetchSuccessful {
                if Session.shared.savedUserData.count > 0 {
                    let saved_user_id = Session.shared.savedUserData[0].user_id
                    let saved_user_auth_token = Session.shared.savedUserData[0].auth_token
                    
                    Session.shared.authToken = saved_user_auth_token
                    
                    UsersNetworkManager.getCurrentUser(user_id: Int(saved_user_id), successHandler: { (currentUser) in
                        Session.shared.currentUser = currentUser
                        
                        self.tableView.reloadData()
                        self.tableView.isHidden = false
                        
                        self.refreshControl.endRefreshing()
                    }, failureHandler: { (error) in
                        print(error)
                        
                        self.refreshControl.endRefreshing()
                    })
                }
            }
        }
    }
    
    // Retrieve the data from the persistent container using a fetch request
    func fetchUserData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<SavedUserData>(entityName: "SavedUserData")
        
        do {
            Session.shared.savedUserData = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            print("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: homeTableViewCellIdentifiers[indexPath.row + 1]!)
            self.revealViewController().setFront(vc, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Session.shared.isLoggedIn() {
            if Session.shared.currentUser!.ceo {
                return 4
            } else if Session.shared.currentUser!.man {
                return 3
            } else {
                return 2
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell {
            
            let title = homeTableViewCellTitles[indexPath.row + 1]
            let number = "\(1)"
            let icon = homeTableViewCellIcons[indexPath.row + 1]
            
            let btnTitle = homeTableViewCellButtonTitle[indexPath.row + 1]
            let mainViewColor = homeTableViewCellMainViewColor[indexPath.row + 1]
            let secondaryViewColor = homeTableViewCellSecondaryViewColor[indexPath.row + 1]
            
            cell.configureCell(index: indexPath.row + 1, cellTitle: title!, cellNumber: number, cellFontAwesome: icon!, btnTitle: btnTitle!, mainViewColor: mainViewColor!, secondaryViewColor: secondaryViewColor!)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        return HomeCell()
    }
    
}
