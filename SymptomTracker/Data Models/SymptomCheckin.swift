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

struct SymptomCheckin: Codable {

    var symtom: Symptom
    var severity: Severity?
}
