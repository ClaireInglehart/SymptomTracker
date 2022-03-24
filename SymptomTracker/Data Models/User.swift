//
//  User.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

class User: Codable {
    var email: String
    var password: String
    
    var symptoms: [Symptom]
    var checkins: [Checkin]
    var customValue: [valueCustom]
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.symptoms = []
        self.checkins = []
        self.customValue = []

    }
}
