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

let CONFIG_0 = ApiConfig(role: .SuperUser, weightUnits: .Kilogram, userPets: 3, userPetsAllowed: 10, canAddNewPet: true)
let CONFIG_1 = ApiConfig(role: .User, weightUnits: .Kilogram, userPets: 3, userPetsAllowed: 3, canAddNewPet: false)

let USER_0 = ApiUser(id: "USER-0", email: "amadeusz@blanik.me", fullName: "Amadeusz Blanik", firstName: "Amadeusz", lastName: "Blanik", isActive: true, isEmailVerified: true, weightUnit: .Kilogram, userRole: .SuperUser, createdAt: Date(), updatedAt: Date())

let SIMPLE_USER_0 = ApiUserSimple(email: "amadeusz@blanik.me", fullName: "Amadeusz Blanik", firstName: "Amadeusz", lastName: "Blanik")

let SIMPLE_MEDICINE_0 = ApiShortMedicineValue(productNumber: "MEDICINE-0", name: "Medicine from database")

let HEALTHLOG_0 = ApiHealthLogValue(id: "HEALTH-LOG-0", kind: .Deworming, date: "2022-03-23", medicine: [SIMPLE_MEDICINE_0], additionalMedicines: ["Medicine added by user"], veterinary: "London, Common Str 1024", diagnosis: "Everything is good", nextVisit: Date(), description: "Lorem ipsum dolor sit amet",  addedBy: SIMPLE_USER_0, createdAt: Date(), updatedAt: Date())
let HEALTHLOG_1 = ApiHealthLogValue(id: "HEALTH-LOG-1", kind: .ExternalParasite, date: "2022-03-24", medicine: [], additionalMedicines: ["Medicine added by user"], addedBy: SIMPLE_USER_0, createdAt: Date(), updatedAt: Date())
let HEALTHLOG_2 = ApiHealthLogValue(id: "HEALTH-LOG-2", kind: .Treatment, date: "2022-03-25", medicine: [], additionalMedicines: [], addedBy: SIMPLE_USER_0, createdAt: Date(), updatedAt: Date())

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
    birthDate: Date(timeIntervalSince1970: 1656324000),
    healthLog: 0,
    breed: BREED_ENGLISH_SETTER,
    createdAt: Date(),
    updatedAt: Date()
)
