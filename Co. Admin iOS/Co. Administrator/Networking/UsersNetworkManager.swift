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

    
    class func getCurrentUser(user_id: Int, successHandler: @escaping ((User) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/\(user_id)", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let user = User(json: json)
                    successHandler(user)
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
