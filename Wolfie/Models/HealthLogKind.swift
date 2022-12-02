//
//  HealthLogKind.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation
import RealmSwift

enum HealthLogKind: String, CaseIterable, Codable, PersistableEnum {
    case VaccinationRabies = "VACCINATION_RABIES"
    case Vaccination = "VACCINATION"
    case Deworming = "DEWORMING"
    case ExternalParasite = "EXTERNAL_PARASITE"
    case RegulationsOfBreeding = "REGULATIONS_OF_BREEDING"
    case UseOfGamaglobulin = "USE_OF_GAMAGLOBULIN"
    case Treatment = "TREATMENT"
    
    var localized: String {
        return NSLocalizedString("health_log_kind_\(rawValue.lowercased())", comment: "")
    }
    
    static var selectItemList: [SelectItem] {
        return allCases.map() { healthLogKind in
            return SelectItem(label: healthLogKind.localized, id: healthLogKind.rawValue)
        }
    }
}
