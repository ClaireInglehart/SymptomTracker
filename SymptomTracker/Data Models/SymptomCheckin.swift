//
//  SymptomCheckin.swift
//  SymptomTracker
//
//  Created on 2/12/22.
//

import Foundation

enum Severity: Int, Codable {
    case none
    case mild
    case moderate
    case difficult
    case severe
    case verySevere
}

class SymptomCheckin: Codable {

    var symptom: Symptom
    var severity: Severity?
    var customTriggerCheckins: [CustomTriggerCheckin]
    var appleHealthTriggerCheckins: [AppleHealthTriggerCheckin]
    
    init(symptom: Symptom, severity: Severity) {
        self.symptom = symptom
        self.severity = severity
        self.customTriggerCheckins = []
        self.appleHealthTriggerCheckins = []
    }
    
    public func checkinForCustomTrigger(_ trigger: CustomTrigger) -> CustomTriggerCheckin? {
        for checkin in self.customTriggerCheckins {
            if (checkin.trigger.name == trigger.name) {
                return checkin
            }
        }
        return nil
    }

    public func checkinForAppleHealthTrigger(_ trigger: AppleHealthTrigger) -> AppleHealthTriggerCheckin? {
        for checkin in appleHealthTriggerCheckins {
            if (checkin.trigger.identifier == trigger.identifier) {
                return checkin
            }
        }
        return nil
    }

}
