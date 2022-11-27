//
//  ConfigDb.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 27/11/2022.
//

import Foundation
import RealmSwift

class ConfigDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var role: UserRoles
    @Persisted var weightUnits: WeightUnits
    @Persisted var userPets: Int
    @Persisted var userPetsAllowed: Int
    @Persisted var canAddNewPet: Bool

    static func fromApi(data: ApiConfig, userEmail: String) -> ConfigDB {
        let dataDb = ConfigDB()
        dataDb.id = userEmail
        dataDb.role = data.role
        dataDb.weightUnits = data.weightUnits
        dataDb.userPets = data.userPets
        dataDb.userPetsAllowed = data.userPetsAllowed
        dataDb.canAddNewPet = data.canAddNewPet

        return dataDb
    }
}
