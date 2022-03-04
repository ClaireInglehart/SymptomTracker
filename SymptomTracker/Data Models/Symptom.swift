//
//  Symptom.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

import Foundation

class Symptom: Codable {
    var name: String
    var customTriggers: [CustomTrigger]
    var appleHealthTriggers: [AppleHealthTrigger]
    
    init(name: String) {
        self.name = name
        self.customTriggers = []
        self.appleHealthTriggers = []
    }
}
