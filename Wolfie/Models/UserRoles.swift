//
//  UserRoles.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation

enum UserRoles: String, CaseIterable, Codable {
    case Banned = "BANNED"
    case User = "USER"
    case SuperUser = "SUPERUSER"
    
    var localized: String {
        return NSLocalizedString("user_role_\(rawValue.lowercased())", comment: "")
    }
    
    static var selectItemList: [SelectItem] {
        return allCases.map() { healthLogKind in
            return SelectItem(label: healthLogKind.localized, id: healthLogKind.rawValue)
        }
    }
}
