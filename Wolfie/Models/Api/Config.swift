//
//  Config.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation

struct ApiConfig: Codable {
    var role: UserRoles
    var weightUnits: WeightUnits
    var userPets: Int
    var userPetsAllowed: Int
    var canAddNewPet: Bool
}
