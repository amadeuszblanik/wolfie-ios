//
//  ApiPets.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation

let BREED_SCHNAUZER = ApiBreed(id: -1, name: "schnauzer", group: "Schnauzer", createdAt: Date(), updatedAt: Date())

let PET_GOLDIE = ApiPetSingle(
    id: "123",
    name: "Goldie",
    kind: .Dog,
    microchip: "616000000000000",
    image: "https://uploads.wolfie.app/SU1HXzQ0MTUtMTY2NDczNTE0ODg4Mw.jpg",
    birthDate: Date(timeIntervalSince1970: 1644663600),
    healthLog: 8,
    breed: BREED_SCHNAUZER,
    createdAt: Date(),
    updatedAt: Date()
)
