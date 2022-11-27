//
//  UserDb.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 27/11/2022.
//

import Foundation
import RealmSwift

class UserDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var email: String
    @Persisted var fullName: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var isActive: Bool
    @Persisted var isEmailVerified: Bool
    @Persisted var weightUnit: WeightUnits
    @Persisted var userRole: UserRoles
    @Persisted var createdAt: Date
    @Persisted var updatedAt: Date

    static func fromApi(data: ApiUser) -> UserDB {
        let dataDb = UserDB()
        dataDb.email = data.email
        dataDb.fullName = data.fullName
        dataDb.firstName = data.firstName
        dataDb.lastName = data.lastName
        dataDb.isActive = data.isActive
        dataDb.isEmailVerified = data.isEmailVerified
        dataDb.weightUnit = data.weightUnit
        dataDb.userRole = data.userRole
        dataDb.createdAt = data.createdAt
        dataDb.updatedAt = data.updatedAt

        return dataDb
    }
}
