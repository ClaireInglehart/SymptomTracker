//
//  TDSelectionCategory.swift
//  TDLikertScaleSelectorView
//
//  Created by Paul Leo on 27/07/2018.
//  Copyright © 2018 tapdigital Ltd. All rights reserved.
//

import Foundation

public enum TDSelectionCategory: Int, CaseIterable {
    case none = 0
    case mild = 1
    case moderate = 2
    case difficult = 3
    case severe = 4

    public var localizedName: String {
        get {
            switch self {
            case .none:
                return NSLocalizedString("none", comment: "none")
            case .mild:
                return NSLocalizedString("mild", comment: "mild")
            case .moderate:
                return NSLocalizedString("moderate", comment: "moderate")
            case .difficult:
                return NSLocalizedString("difficult", comment: "difficult")
            case .severe:
                return NSLocalizedString("severe", comment: "severe")
            }
        }
    }
}
