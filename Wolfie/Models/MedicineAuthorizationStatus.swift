//
//  MedicineAuthorizationStatus.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 16/11/2022.
//

import Foundation
import RealmSwift

enum MedicineAuthorizationStatus: String, CaseIterable, PersistableEnum {
    case Authorized = "AUTHORIZED"
    case Withdrawn = "WITHDRAWN"
    case Refused = "REFUSED"
    
    var localized: String {
        return NSLocalizedString("medicine_authorization_status_\(rawValue.lowercased())", comment: "")
    }
}
