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
    
    class func getManagerCount(successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/manager_count", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let manager_count = json["manager_count"].intValue
                    successHandler(manager_count)
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
    
    class func getEmployeeCountForMan(successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/employee_count_for_man", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let employee_count = json["employee_count"].intValue
                    successHandler(employee_count)
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
    
    class func getEmployeeCountForCeo(successHandler: @escaping ((Int) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/employee_count_for_ceo", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let employee_count = json["employee_count"].intValue
                    successHandler(employee_count)
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
    
    class func getManagers(successHandler: @escaping (([Int: employeeInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/get_managers", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    var result: [Int: employeeInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let managerList = dict["manager_list"]! as! [[String: Any]]
                    
                    for manager in managerList {
                        let managerInfo = employeeInformation(firstName: manager["first_name"] as! String, lastName: manager["last_name"] as! String, email: manager["email"] as! String)
                        
                        result[k] = managerInfo
                        k += 1
                    }
                    
                    successHandler(result)
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
    
    class func getEmployees(successHandler: @escaping (([Int: employeeInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token]
        
        Alamofire.request("\(Session.host())/users/get_employees", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    var result: [Int: employeeInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let employeeList = dict["employee_list"]! as! [[String: Any]]
                    
                    for employee in employeeList {
                        let empInfo = employeeInformation(firstName: employee["first_name"] as! String, lastName: employee["last_name"] as! String, email: employee["email"] as! String)
                        
                        result[k] = empInfo
                        k += 1
                    }
                    
                    successHandler(result)
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
    
    class func getEmployeesForMan(managerEmail: String, successHandler: @escaping (([Int: employeeInformation]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "manager_email": managerEmail]
        
        Alamofire.request("\(Session.host())/users/get_employees_for_man", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    var result: [Int: employeeInformation] = [:]
                    var k = 0
                    
                    let dict = json.dictionaryObject!
                    let employeeList = dict["employee_list"]! as! [[String: Any]]

                    for employee in employeeList {
                        let empInfo = employeeInformation(firstName: employee["first_name"] as! String, lastName: employee["last_name"] as! String, email: employee["email"] as! String)

                        result[k] = empInfo
                        k += 1
                    }
                    
                    successHandler(result)
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
    
    class func getSuperiorForEmp(employeeEmail: String, successHandler: @escaping (([String: Any]) -> Void), failureHandler: @escaping ((String) -> Void)) {
        
        let auth_token = Session.shared.authToken!
        let params: Parameters = ["auth_token": auth_token, "employee_email": employeeEmail]
        
        Alamofire.request("\(Session.host())/users/get_superior_of_employee", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    var result: [String: Any] = [:]
                    
                    result["first_name"] = json["first_name"].stringValue
                    result["last_name"] = json["last_name"].stringValue
                    result["email"] = json["email"].stringValue
                    
                    successHandler(result)
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
