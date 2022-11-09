//
//  ApiPets.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation

let BREED_ENGLISH_POINTER = ApiBreed(id: 1, name: "english_pointer", group: "English Pointer", createdAt: Date(), updatedAt: Date())
let BREED_ENGLISH_SETTER = ApiBreed(id: 2, name: "english_setter", group: "English Setter", createdAt: Date(), updatedAt: Date())
let BREED_GIANT_SCHNAUZER = ApiBreed(id: 181, name: "giant_schnauzer", group: "Schnauzer", createdAt: Date(), updatedAt: Date())
let BREED_SCHNAUZER = ApiBreed(id: 182, name: "schnauzer", group: "Schnauzer", createdAt: Date(), updatedAt: Date())
let BREED_MINIATURE_SCHNAUZER = ApiBreed(id: 183, name: "miniature_schnauzer", group: "Schnauzer", createdAt: Date(), updatedAt: Date())

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
