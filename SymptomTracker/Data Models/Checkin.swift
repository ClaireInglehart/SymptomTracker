//
//  Checkin.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

struct Checkin: Codable {
    var date: String
    var symptoms: [Symptom]
}
