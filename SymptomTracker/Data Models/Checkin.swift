//
//  Checkin.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

class Checkin: Codable {
    var date: String
    var triggerCheckins: [TriggerCheckin]
    var symptomCheckins: [SymptomCheckin]
}
