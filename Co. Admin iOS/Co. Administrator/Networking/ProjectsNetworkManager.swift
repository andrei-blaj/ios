//
//  ProjectsNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 18/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProjectsNetworkManager {
    
    class func getProjectCount(userEmail: String, successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "user_email": userEmail]
        
        Alamofire.request("\(Session.host())/projects/project_count", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let projectCount = json["project_count"].intValue
                    successHandler(projectCount)
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
    
    class func getProjects(successHandler: @escaping (([Int: ProjectInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "user_email": Session.shared.currentUser!.email]
        
        Alamofire.request("\(Session.host())/projects/get_projects", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    var result: [Int: ProjectInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let projectList = dict["projects"]! as! [[String: Any]]
                    
                    for project in projectList {
                        let projectInfo = ProjectInformation(name: project["title"] as! String, deadline: project["deadline"] as! String, completed: project["completed"] as! Bool, id: project["id"] as! Int)
                        
                        result[k] = projectInfo
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
    
    class func delete(projectId: Int, completion: @escaping (_ complete: Bool) -> ()) {
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "project_id": projectId]
    
        Alamofire.request("\(Session.host())/projects/\(projectId)", method: .delete, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
