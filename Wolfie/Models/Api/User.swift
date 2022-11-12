//
//  User.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

struct ApiUser: Identifiable, Codable {
    public var id: String
    var email: String
    var fullName: String
    var firstName: String
    var lastName: String
    var isActive: Bool
    var isEmailVerified: Bool
    var weightUnit: WeightUnits
    var userRole: UserRoles
    var createdAt: Date
    var updatedAt: Date
}

struct ApiUserSimple: Identifiable, Codable {
    var email: String
    var fullName: String
    var firstName: String
    var lastName: String
    
    public var id: String { self.email }
}
