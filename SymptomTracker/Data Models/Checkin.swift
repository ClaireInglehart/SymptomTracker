//
//  Checkin.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

import Foundation

class Checkin: Codable {
    private var dateString: String
    public var symptomCheckins: [SymptomCheckin] = []
    public var date: Date {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter.date(from: self.dateString) ?? Date()
        }
    }
    init(date: Date, symptomCheckins: [SymptomCheckin]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        self.dateString = formatter.string(from: date)
        self.symptomCheckins.append(contentsOf: symptomCheckins)
    }
        
}



