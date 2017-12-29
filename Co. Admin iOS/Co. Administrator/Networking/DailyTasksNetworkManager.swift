//
//  DailyTasksNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei Blaj on 27/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DailyTasksNetworkManager {
    
    class func getDailyTasks(projectId: Int, successHandler: @escaping (([Int: TaskInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "project_id": projectId]
        
        Alamofire.request("\(Session.host())/daily_tasks/get_tasks", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    var result: [Int: TaskInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let taskList = dict["daily_tasks"]! as! [[String: Any]]
                    
                    for task in taskList {
                        let taskInfo = TaskInformation(taskDescription: task["task_description"] as! String, taskDeadline: task["task_deadline"] as! String, completed: task["completed"] as! Bool, id: task["id"] as! Int)
                        
                        result[k] = taskInfo
                        k += 1
                    }
                    
                    successHandler(result)
                case .failure(let error):
                    print(error)
                    guard let errorMessage = String(data: response.data!, encoding: .utf8) else {
                        failureHandler("Sorry. Server Problem.")
                        return
                    }
                    failureHandler(errorMessage)
                }
        }
        
    }
    
    class func getContributionsForDailyTask(withId taskId: Int, successHandler: @escaping (([Int: ContributionInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "daily_task_id": taskId]
        
        Alamofire.request("\(Session.host())/contributions/get_contributions", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
            
                    var result: [Int: ContributionInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let contributions = dict["contributions"] as! [[String: Any]]
                    
                    for contribution in contributions {
                        let content = contribution["content"] as! String
                        let image = contribution["image"] as! [String: Any]
                        let imageUrl = image["url"] as! String
                        let userId = contribution["user_id"] as! Int
                        let createdAt = contribution["created_at"] as! String

                        let contributionToAdd = ContributionInformation(content: content, userId: userId, createdAt: createdAt, imagePath: imageUrl)
                        
                        result[k] = contributionToAdd
                        k += 1
                        
                    }
                    
                    successHandler(result)
                case .failure(let error):
                    print(error)
                    guard let errorMessage = String(data: response.data!, encoding: .utf8) else {
                        failureHandler("Sorry. Server Problem.")
                        return
                    }
                    failureHandler(errorMessage)
                }
        }
        
    }
    
    
    
    
}
