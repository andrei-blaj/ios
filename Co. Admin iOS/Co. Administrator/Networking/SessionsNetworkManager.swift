//
//  SessionsNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 11/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SessionsNetworkManager {
    
    class func login(email: String, password: String, successHandler: @escaping ((Int, String) -> Void), failureHandler: @escaping ((String) -> Void)) {
        let params: Parameters = ["email" : email, "password" : password]
        Alamofire.request("\(Session.host())/login",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    let id = json["user_id"].intValue
                    let authToken = json["auth_token"].stringValue
                    
                    Session.shared.authToken = authToken
                    
                    successHandler(id, authToken)
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
