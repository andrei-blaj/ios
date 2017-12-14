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

struct User {
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.registerAs = json["register_as"].stringValue
        self.companyName = json["company_name"].stringValue
        self.ceoEmail = json["ceo_email"].stringValue
        self.managerEmail = json["manager_email"].stringValue
        self.ceo = json["ceo"].boolValue
        self.man = json["man"].boolValue
        self.emp = json["emp"].boolValue
        self.paid = json["paid"].boolValue
        self.numOfManagers = json["num_of_managers"].intValue
        self.numOfEmployees = json["num_of_employees"].intValue
        self.companyPlanId = json["company_plan_id"].intValue
    }
    
    var _id: Int!
    var _email: String!, _firstName: String!, _lastName: String!
    var _registerAs: String!, _companyName: String!
    var _ceoEmail: String!, _managerEmail: String!
    var _ceo: Bool!, _man: Bool!, _emp: Bool!, _paid: Bool!
    var _numOfManagers: Int!, _numOfEmployees: Int!, _companyPlanId: Int!
    
    var id: Int {
        get { return _id == nil ? 0 : _id }
        set { _id = newValue }
    }
    
    var email: String {
        get { return _email == nil ? "" : _email }
        set { _email = newValue }
    }
    
    var firstName: String {
        get { return _firstName == nil ? "" : _firstName }
        set { _firstName = newValue }
    }
    
    var lastName: String {
        get { return _lastName == nil ? "" : _lastName }
        set { _lastName = newValue }
    }
    
    var registerAs: String {
        get { return _registerAs == nil ? "" : _registerAs }
        set { _registerAs = newValue }
    }
    
    var companyName: String {
        get { return _companyName == nil ? "" : _companyName }
        set { _companyName = newValue }
    }
    
    var ceoEmail: String {
        get { return _ceoEmail == nil ? "" : _ceoEmail }
        set { _ceoEmail = newValue }
    }
    
    var managerEmail: String {
        get { return _managerEmail == nil ? "" : _managerEmail }
        set { _managerEmail = newValue }
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
    
    var numOfManagers: Int {
        get { return _numOfManagers == nil ? 0 : _numOfManagers }
        set { _numOfManagers = newValue }
    }
    
    var numOfEmployees: Int {
        get { return _numOfEmployees == nil ? 0 : _numOfEmployees }
        set { _numOfEmployees = newValue }
    }
    
    var companyPlanId: Int {
        get { return _companyPlanId == nil ? 0 : _companyPlanId }
        set { _companyPlanId = newValue }
    }
    
}
