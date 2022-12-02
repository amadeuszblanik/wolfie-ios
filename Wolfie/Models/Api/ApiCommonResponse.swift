//
//  ApiCommonResponse.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 02/12/2022.
//

import Foundation

struct ApiCommonResponse: Decodable {
    let message: String?
    let success: Bool
}
