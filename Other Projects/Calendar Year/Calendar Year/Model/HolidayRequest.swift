//
//  HolidayRequest.swift
//  Calendar Year
//
//  Created by Andrei Blaj on 3/8/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let API_KEY = "22ba61a8f730707fd2460993f807b12bac3e2c4b"
    let BASE_URL = "https://calendarific.com/api/v2"
    let HOLIDAYS_ENDPOINT = "/holidays"
    let COUNTRIES_ENDPOINT = "/countries"
    
    let resourceUrl: URL
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = BASE_URL + HOLIDAYS_ENDPOINT + "?api_key=" + API_KEY + "&country=" + countryCode + "&year=" + currentYear
        guard let resourceUrl = URL(string: resourceString) else { fatalError() }
        
        self.resourceUrl = resourceUrl
    }
    
    func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { (data, urlResponse, error) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            
        }
        
        dataTask.resume()
    }
    
}
