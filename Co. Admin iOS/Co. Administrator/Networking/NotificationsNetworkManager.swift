//
//  NotificationsNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 02/01/2018.
//  Copyright © 2018 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire

class NotificationsNetworkManager {
    
    class func getProjectNotifications(successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        print("gagagagagagaga 2")
        
        Alamofire.request("\(Session.host())/notifications/notif_count",
            parameters: params)
            .responseJSON { response in
                if response.result.error == nil {
                    
                    guard let dict = response.result.value! as? [String: Int] else { return }
                    let notif_count = dict["notif_count"]
                    
                    successHandler(notif_count!)
                    
                } else {
                    print(response.result.error)
                    guard let errorMessage = String(data: response.data!, encoding: .utf8) else {
                        failureHandler("Sorry. Server Problem.")
                        return
                    }
                    failureHandler(errorMessage)
                }
        }
        
    }
    
}
