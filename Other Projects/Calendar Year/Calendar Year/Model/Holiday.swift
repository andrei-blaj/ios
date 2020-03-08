//
//  Holiday.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/8/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
