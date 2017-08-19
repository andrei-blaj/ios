//
//  AuthService.swift
//  Smack
//
//  Created by Andrei-Sorin Blaj on 12/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        // Alamofire post request with a JSON Encoding, with a string response that confirms or denies the registration of the user
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    // Runs through the process of logging in a user
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        // Alamofire post request for logging in a user, with a JSON Encoding, returning a json response containing the user email and auth token
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                // Old fashioned way of working with JSON
                //                if let json = response.result.value as? Dictionary<String, Any> {
                //
                //                    if let email = json["user"] as? String {
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                //
                //                }
                
                // SwiftyJSON
                guard let data = response.data else { return }
                
                let json = JSON(data: data)
                
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
    
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                
                self.setUserData(data: data)
                
                completion(true)
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }

    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                
                self.setUserData(data: data)
                
                completion(true)
                
            } else {
                
                completion(false)
                debugPrint(response.result.error as Any)
            
            }
            
        }
        
    }
    
    func setUserData(data: Data) {
        
        let json = JSON(data: data)
        
        let jsonId = json["_id"].stringValue
        let jsonColor = json["avatarColor"].stringValue
        let jsonAvatarName = json["avatarName"].stringValue
        let jsonEmail = json["email"].stringValue
        let jsonName = json["name"].stringValue
        
        UserDataService.instance.setUserData(id: jsonId, avatarColor: jsonColor, avatarName: jsonAvatarName, email: jsonEmail, name: jsonName)
        
    }
    
}
