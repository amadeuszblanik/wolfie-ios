//
//  SignIn.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

public struct ApiSignIn: Decodable {
    let accessToken: String
    let refreshToken: String?
}
