//
//  PetsSingle.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation

public struct ApiPetSingle: Identifiable, Codable {
    public var id: String
    var name: String
    var kind: PetKind
    var microchip: String?
    var image: String
    var currentWeight: ApiWeightValue?
    var birthDate: Date
    var healthLog: Int
    var breed: ApiBreed?
    var createdAt: Date
    var updatedAt: Date
}
