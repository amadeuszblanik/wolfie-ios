//
//  WeightValue.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation
import RealmSwift


struct ApiWeightValue: Identifiable, Codable {
    public var id: String
    var raw: Float
    var formatted: String
    var rawGram: Float
    var date: Date
    var createdAt: Date
    var updatedAt: Date
}
