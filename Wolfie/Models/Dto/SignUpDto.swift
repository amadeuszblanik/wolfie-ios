//
//  SignUpDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

public struct DtoSignUp: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    var passwordConfirm: String
    var weightUnit: String
    var gdprConsent: Bool
}
