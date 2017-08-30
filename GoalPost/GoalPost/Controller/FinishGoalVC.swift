//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Andrei-Sorin Blaj on 30/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    // Variables
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pointsTextField.delegate = self
        
        createGoalBtn.bindToKeyboard()
        
    }

    // Actions
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        // Pass data into Core Data Goal Model
        
        if pointsTextField.text != "" {
            self.save(completion: { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            })
        }
        
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalType = goalType.rawValue
        goal.goalDescription = goalDescription
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}
