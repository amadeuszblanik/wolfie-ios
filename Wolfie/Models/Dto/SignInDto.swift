//
//  SignUpDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

public struct DtoSignIn: Codable {
    var username: String
    var password: String
    var keepSignIn: Bool?
    var device: String?
}
