//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Andrei-Sorin Blaj on 29/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    // Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Variables
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTextView.delegate = self
        
        nextBtn.bindToKeyboard()
        
        // By default the shortTermBtn is selected
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        
    }
    
    // Actions
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
            
        }
        
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        // Dismisses the current view controller
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
    }
    
}
