//
//  ContributionsNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 31/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContributionsNetworkManager {
    
    class func createContribution(userId: Int, dailyTaskId: Int, image: String, content: String, timeStamp: String, completion: @escaping (_ complete: Bool) -> ()) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "user_id": userId, "daily_task_id": dailyTaskId, "image": image, "content": content, "timestamp": timeStamp]
        
        Alamofire.request("\(Session.host())/contributions/create_contribution",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if response.result.error == nil {
                    completion(true)
                } else {
                    debugPrint(response.result.error as Any)
                    completion(false)
                }
        }
        
    }
    
    class func deleteContribution(contributionId: Int, completion: @escaping (_ complete: Bool) -> ()) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "contribution_id": contributionId]
        
        Alamofire.request("\(Session.host())/contributions/\(contributionId)",
            method: .delete,
            parameters: params,
            encoding: JSONEncoding.default)
            .responseJSON { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
}
