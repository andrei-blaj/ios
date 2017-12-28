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
                        let taskInfo = TaskInformation(taskDescription: task["task_description"] as! String, taskDeadline: task["task_deadline"] as! String, completed: task["completed"] as! Bool)
                        
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
}
