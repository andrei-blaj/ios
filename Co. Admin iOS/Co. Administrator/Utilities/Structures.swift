//
//  Enums.swift
//  Co. Administrator
//
//  Created by Andrei-Sorin Blaj on 14/12/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import Foundation

struct employeeInformation {
    var firstName: String
    var lastName: String
    var email: String
}

struct ProjectInformation {
    var name: String
    var deadline: String
    var completed: Bool
    var id: Int
}

// Home Page Table View Cell Elements

let homeTableViewCellTitles: [Int: String] = [1: "Welcome!",
                                              2: "Number of projects:",
                                              3: "Number of employees:",
                                              4: "Number of managers:"]

let homeTableViewCellIcons: [Int: String] = [1: "fa-home", 2: "fa-folder-open-o", 3: "fa-user", 4: "fa-users"]

let homeTableViewCellButtonTitle: [Int: String] = [1: "See more info",
                                                   2: "See projects",
                                                   3: "See employees",
                                                   4: "See managers"]

let homeTableViewCellSegues: [Int: String] = [1: "toMainVC", 2: "toSeeProjectsVC", 3: "toSeeEmployeesVC", 4: "toSeeManagersVC"]

let homeTableViewCellIdentifiers: [Int: String] = [1: "mainVC", 2: "projectsVC", 3: "employeesVC", 4: "managersVC"]

let homeTableViewCellMainViewColor: [Int: UIColor] = [1: #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1), 2: #colorLiteral(red: 0.9980931878, green: 0.7577217221, blue: 0.03260162845, alpha: 1), 3: #colorLiteral(red: 0.8642227054, green: 0.2102498114, blue: 0.2715340257, alpha: 1), 4: #colorLiteral(red: 0.1565668285, green: 0.6565688252, blue: 0.2710740268, alpha: 1)]

let homeTableViewCellSecondaryViewColor: [Int: UIColor] = [1: #colorLiteral(red: 0, green: 0.4641603231, blue: 0.9672572017, alpha: 1), 2: #colorLiteral(red: 0.9665305018, green: 0.7340477109, blue: 0.04193002731, alpha: 1), 3: #colorLiteral(red: 0.8364867568, green: 0.2026563585, blue: 0.2643864155, alpha: 1), 4: #colorLiteral(red: 0.1493210196, green: 0.6367949843, blue: 0.2639911175, alpha: 1)]

// Company Plan

let companyPlan: [Int: String] = [1: "Start-Up", 2: "Expanding", 3: "Business", 4: "Enterprise"]

// Side Menu Table View Cell Elements

// CEO

let ceoSegues : [Int: String] = [1: "toMainVC",
                                 2: "toSeeManagersVC",
                                 3: "toSeeEmployeesVC",
                                 4: "toSeeProjectsVC"]

let ceoMenuIcons : [Int: String] = [1: "fa-home",
                                    2: "fa-user",
                                    3: "fa-users",
                                    4: "fa-files-o"]

let ceoMenuElements : [Int: String] = [1: "Home",
                                       2: "See Managers",
                                       3: "See Employees",
                                       4: "See Projects"]

 // MAN

let manSegues : [Int: String] = [1: "toMainVC",
                                 2: "toSeeEmployeesVC",
                                 3: "toSeeProjectsVC"]

let manMenuIcons : [Int: String] = [1: "fa-home",
                                    2: "fa-users",
                                    3: "fa-files-o"]

let manMenuElements : [Int: String] = [1: "Home",
                                       2: "See Employees",
                                       3: "See Projects"]

// EMP

let empSegues : [Int: String] = [1: "toMainVC",
                                 2: "toSeeProjectsVC"]

let empMenuIcons : [Int: String] = [1: "fa-home",
                                    2: "fa-files-o"]

let empMenuElements : [Int: String] = [1: "Home",
                                       2: "See Projects"]

// Upgrade Plan

let cellHeadings : [Int: String] = [1: "Expanding",
                                    2: "Business",
                                    3: "Enterprise"]

let managers : [Int: String] = [1: "5",
                                2: "15",
                                3: "Unlimited"]

let employees : [Int: String] = [1: "30",
                                2: "150",
                                3: "Unlimited"]

let projects : [Int: String] = [1: "20",
                                2: "50",
                                3: "Unlimited"]

let prices : [Int: String] = [1: "$99",
                             2: "$199",
                             3: "$399"]




