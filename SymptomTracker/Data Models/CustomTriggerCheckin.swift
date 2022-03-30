//
//  TriggerCheckin.swift
//  SymptomTracker
//
//  Created on 2/12/22.
//

import Foundation

class CustomTriggerCheckin: Codable {

    var trigger: CustomTrigger
    var quantity: String?
    
    init(trigger: CustomTrigger, quantity: String) {
        self.trigger = trigger
        self.quantity = quantity
    }
}
