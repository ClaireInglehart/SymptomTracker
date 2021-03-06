//
//  AppleHealthTriggerCheckin.swift
//  SymptomTracker
//
//  Created by Mike on 3/4/22.
//

import Foundation

class AppleHealthTriggerCheckin: Codable {

    var trigger: AppleHealthTrigger
    var quantity: Double
    
    init(trigger: AppleHealthTrigger, quantity: Double) {
        self.trigger = trigger
        self.quantity = quantity
    }
}
