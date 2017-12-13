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
                    
                    let currentUser: [String: Any] = [
                        "id": json["id"].intValue,
                        "email": json["email"].stringValue,
                        "first_name": json["first_name"].stringValue,
                        "last_name": json["last_name"].stringValue,
                        "register_as": json["register_as"].stringValue,
                        "company_name": json["company_name"].stringValue,
                        "ceo_email": json["ceo_email"].stringValue,
                        "manager_email": json["manager_email"].stringValue,
                        "ceo": json["ceo"].boolValue,
                        "man": json["man"].boolValue,
                        "emp": json["emp"].boolValue,
                        "paid": json["paid"].boolValue,
                        "num_of_managers": json["num_of_managers"].intValue,
                        "num_of_employees": json["num_of_employees"].intValue,
                        "company_plan_id": json["company_plan_id"].intValue
                    ]
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
