//
//  User.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

class User: Codable {
    var email: String
    var passwordDigest: String
    
    var symptoms: [Symptom]
    var checkins: [Checkin]
    init(email: String, passwordDigest: String) {
        self.email = email
        self.passwordDigest = passwordDigest
        self.symptoms = []
        self.checkins = []

    }
}
