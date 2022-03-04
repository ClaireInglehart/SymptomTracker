//
//  Trigger.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

import Foundation

class CustomTrigger: Codable {

    var name: String
    var units: String
    
    init(name: String, units: String) {
        self.name = name
        self.units = units
    }
}
