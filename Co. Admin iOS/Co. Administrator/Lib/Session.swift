//
//  Session.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 13/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Session {

    static let shared = Session()
    
    var currentUser: User?
    var authToken: String?

    class func host() -> String {
        #if arch(i386) || arch(x86_64)
            //simulator
            return "http://localhost:3000/api"
        #else
            //device
            return "http://192.168.43.181:3000/api"
            // return "http://yourapp.herokuapp.com/"
        #endif
    }
    
    func isLoggedIn() -> Bool {
        return authToken != nil
    }
    
}