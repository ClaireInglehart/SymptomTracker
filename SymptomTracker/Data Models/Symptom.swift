//
//  Symptom.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

import Foundation

class Symptom: Codable {
    var name: String
    var triggers: [Trigger]
    
    init(name: String) {
        self.name = name
        self.triggers = []
    }
}
