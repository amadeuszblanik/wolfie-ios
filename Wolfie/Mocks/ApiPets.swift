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

let WEIGHT_142 = ApiWeightValue(id: "ABC-142", raw: 14.2, formatted: "14.2 KG", rawGram: 14200, date: Date(), createdAt: Date(), updatedAt: Date())
let WEIGHT_140 = ApiWeightValue(id: "ABC-140", raw: 14, formatted: "14 KG", rawGram: 14000, date: Date(timeIntervalSinceNow: -86400), createdAt: Date(), updatedAt: Date())
let WEIGHT_138 = ApiWeightValue(id: "ABC-138", raw: 13.8, formatted: "13.8 KG", rawGram: 13800, date: Date(timeIntervalSinceNow: -86400 * 7), createdAt: Date(), updatedAt: Date())

let PET_GOLDIE = ApiPetSingle(
    id: "123",
    name: "Goldie",
    kind: .Dog,
    microchip: "616000000000000",
    image: "https://uploads.wolfie.app/SU1HXzQ0MTUtMTY2NDczNTE0ODg4Mw.jpg",
    currentWeight: WEIGHT_142,
    birthDate: Date(timeIntervalSince1970: 1644663600),
    healthLog: 8,
    breed: BREED_SCHNAUZER,
    createdAt: Date(),
    updatedAt: Date()
)

let PET_TESTIE = ApiPetSingle(
    id: "321",
    name: "Testie",
    kind: .Dog,
    image: "",
    birthDate: Date(timeIntervalSince1970: 1644663600),
    healthLog: 0,
    breed: BREED_ENGLISH_SETTER,
    createdAt: Date(),
    updatedAt: Date()
)
