//
//  WeightUnits.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation

enum WeightUnits: String, CaseIterable, Codable {
    case Kilogram = "KG"
    case Gram = "G"
    case Pound = "LB"
    case Ounce = "OZ"
    
    var localized: String {
        return NSLocalizedString("weight_unit_\(rawValue.lowercased())", comment: "")
    }
    
    static var selectItemList: [SelectItem] {
        return allCases.map() { weightUnit in
            return SelectItem(label: weightUnit.localized, id: weightUnit.rawValue)
        }
    }
}
