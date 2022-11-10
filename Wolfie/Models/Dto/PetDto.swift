//
//  PetDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

public struct DtoPet: Codable {
    var name: String
    var kind: PetKind
    var microchip: String?
    var birthDate: Date
    var breed: Int
}

public struct DtoPetUpdate: Identifiable, Codable {
    public var id: String
    var name: String
    var kind: PetKind
    var microchip: String?
    var birthDate: Date
    var breed: Int
}
