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
    
    class func getNotifications(notificationType: String, successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "notification_type": notificationType]
        
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
    
    class func deleteProjectNotification(withProject id: Int) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "project_id": id]
        
        Alamofire.request("\(Session.host())/notifications/project_notification",
            method: .delete,
            parameters: params,
            encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if response.result.error != nil {
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    
    class func deleteEmployeeNotification(withSender id: Int, notificationType: String) {
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "sender_id": id, "notification_type": notificationType]
        
        Alamofire.request("\(Session.host())/notifications/employee_notification",
            method: .delete,
            parameters: params,
            encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if response.result.error != nil {
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
}
