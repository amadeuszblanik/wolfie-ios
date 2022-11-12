//
//  RefreshToken.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation

struct ApiRefreshToken: Identifiable, Codable {
    public var id: String
    var device: String
    var expiration: Date
}
