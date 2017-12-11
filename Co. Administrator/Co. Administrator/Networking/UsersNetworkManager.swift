//
//  UsersNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 11/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UsersNetworkManager {
    
    class func getCurrentUser(user_id: Int, successHandler: @escaping (([String : Any]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        Alamofire.request("\(NetworkManager.host())/users/\(user_id)",
            method: .get,
            encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    var currentUser = ["id" : json["id"]]
                    
                    currentUser["email"] = json["email"]
                    currentUser["first_name"] = json["first_name"]
                    currentUser["last_name"] = json["last_name"]
                    currentUser["register_as"] = json["register_as"]
                    currentUser["company_name"] = json["company_name"]
                    currentUser["ceo_email"] = json["ceo_email"]
                    currentUser["manager_email"] = json["manager_email"]
                    currentUser["ceo"] = json["ceo"]
                    currentUser["man"] = json["man"]
                    currentUser["emp"] = json["emp"]
                    currentUser["paid"] = json["paid"]
                    currentUser["num_of_managers"] = json["num_of_managers"]
                    currentUser["num_of_employees"] = json["num_of_employees"]
                    currentUser["company_plan_id"] = json["company_plan_id"]
                    
                    //                    let authToken = json["auth_token"].stringValue
                    successHandler(currentUser)
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
