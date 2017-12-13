//
//  User.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 13/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    static let instance = User()
    
    private init() {}
    
    var _id: Int!
    var _email: String!, _first_name: String!, _last_name: String!
    var _register_as: String!, _company_name: String!
    var _ceo_email: String!, _manager_email: String!
    var _ceo: Bool!, _man: Bool!, _emp: Bool!, _paid: Bool!
    var _num_of_managers: Int!, _num_of_employees: Int!, _company_plan_id: Int!
    
    var id: Int {
        get { return _id == nil ? 0 : _id }
        set { _id = newValue }
    }
    
    var email: String {
        get { return _email == nil ? "" : _email }
        set { _email = newValue }
    }
    
    var first_name: String {
        get { return _first_name == nil ? "" : _first_name }
        set { _first_name = newValue }
    }
    
    var last_name: String {
        get { return _last_name == nil ? "" : _last_name }
        set { _last_name = newValue }
    }
    
    var register_as: String {
        get { return _register_as == nil ? "" : _register_as }
        set { _register_as = newValue }
    }
    
    var company_name: String {
        get { return _company_name == nil ? "" : _company_name }
        set { _company_name = newValue }
    }
    
    var ceo_email: String {
        get { return _ceo_email == nil ? "" : _ceo_email }
        set { _ceo_email = newValue }
    }
    
    var manager_email: String {
        get { return _manager_email == nil ? "" : _manager_email }
        set { _manager_email = newValue }
    }
    
    var ceo: Bool {
        get { return _ceo == nil ? false : _ceo }
        set { _ceo = newValue }
    }
    
    var man: Bool {
        get { return _man == nil ? false : _man }
        set { _man = newValue }
    }
    
    var emp: Bool {
        get { return _emp == nil ? false : _emp }
        set { _emp = newValue }
    }
    
    var paid: Bool {
        get { return _paid == nil ? false : _paid }
        set { _paid = newValue }
    }
    
    var num_of_managers: Int {
        get { return _num_of_managers == nil ? 0 : _num_of_managers }
        set { _num_of_managers = newValue }
    }
    
    var num_of_employees: Int {
        get { return _num_of_employees == nil ? 0 : _num_of_employees }
        set { _num_of_employees = newValue }
    }
    
    var company_plan_id: Int {
        get { return _company_plan_id == nil ? 0 : _company_plan_id }
        set { _company_plan_id = newValue }
    }
    
    func setUserData(userData: [String: Any]) {
        
    }
    
}
