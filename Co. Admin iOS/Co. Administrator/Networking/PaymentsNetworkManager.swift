//
//  PaymentsNetworkManager.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 03/01/2018.
//  Copyright © 2018 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Stripe

class PaymentsNetworkManager {
    
    class func pay(token: STPToken, companyPlanId: Int, completion: @escaping (_ complete: Bool) -> ()) {
        
        let auth_token = Session.shared.authToken!
        let params = ["auth_token": auth_token, "stripeToken": token.tokenId, "company_plan_id": companyPlanId] as [String : Any]
        
        Alamofire.request("\(Session.host())/payments/pay",
            method: .post,
            parameters: params)
            .responseJSON { (response) in
                if response.result.error == nil {
                    completion(true)
                } else {
                    print(response.result.error)
                    completion(false)
                }
        }
        
    }
    
}
