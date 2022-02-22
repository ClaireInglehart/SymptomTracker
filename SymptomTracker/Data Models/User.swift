//
//  User.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

class User: Codable {
    var name: String
    var email: String
    
    var symptoms: [Symptom]
    var checkins: [Checkin]
    
    init(name: String, email:String) {
        self.name = name
        self.email = email
        self.symptoms = []
        self.checkins = []
    }
}
