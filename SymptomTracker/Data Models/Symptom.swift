//
//  Symptom.swift
//  SymptomTracker
//
//  Created on 2/10/22.
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

struct Symptom: Codable {

    var name: String
    var severity: Severity?
}
