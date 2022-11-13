//
//  Message.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

struct ApiMessage: Decodable {
    let message: String
    let success: Bool?
}
