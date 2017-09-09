//
//  DeletedGoal.swift
//  GoalPost
//
//  Created by Andrei-Sorin Blaj on 31/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

class DeletedGoal {
    
    // Variables
    var goalType: String!
    var goalDescription: String!
    var goalCompletionValue: Int32!
    var goalProgress: Int32!
    
    init(goal: Goal) {
        self.goalType = goal.goalType
        self.goalDescription = goal.goalDescription
        self.goalCompletionValue = goal.goalCompletionValue
        self.goalProgress = goal.goalProgress
    }
    
}
