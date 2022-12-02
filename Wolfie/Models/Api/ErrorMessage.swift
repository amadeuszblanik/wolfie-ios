//
//  ErrorResponse.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

struct ApiErrorMessage: Decodable {
    let error: String
    let message: String
    let success: Bool?
}
