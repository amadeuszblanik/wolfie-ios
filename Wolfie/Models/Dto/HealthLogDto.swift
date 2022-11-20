//
//  HealthLogDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 20/11/2022.
//

import Foundation

public struct DtoHealthLog: Codable {
    var kind: HealthLogKind
    var date: String
    var medicines: [String]? = nil
    var additionalMedicines: String? = nil
    var diagnosis: String? = nil
    var nextVisit: Date? = nil
    var veterinary: String? = nil
    var description: String? = nil
}
