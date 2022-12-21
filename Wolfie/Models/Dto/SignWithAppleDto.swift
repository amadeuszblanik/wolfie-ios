//
//  SignWithAppleDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 05/12/2022.
//

import Foundation

public struct DtoSignWithApple: Codable {
    var state: String?
    var idToken: String
    var code: String
    var firstName: String?
    var lastName: String?
    var email: String?
}
