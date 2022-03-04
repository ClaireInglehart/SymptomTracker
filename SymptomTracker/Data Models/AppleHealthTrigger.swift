//
//  AppleHealthTrigger.swift
//  SymptomTracker
//
//  Created by Mike on 3/4/22.
//

import Foundation
import HealthKit

class AppleHealthTrigger: Codable {

    var name: String
    var identifier: HKQuantityTypeIdentifier
    
    init(name: String, identifier: HKQuantityTypeIdentifier) {
        self.name = name
        self.identifier = identifier
    }

    enum CodingKeys: String, CodingKey {
        case name
        case identifier
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(String(identifier.rawValue), forKey: .identifier)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let identifierString = try values.decode(String.self, forKey: .identifier)
        identifier = HKQuantityTypeIdentifier(rawValue: identifierString)
    }
}
