//
//  User.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

struct ApiUserSimple: Identifiable, Codable {
    var email: String
    var fullName: String
    var firstName: String
    var lastName: String
    
    public var id: String { self.email }
}
