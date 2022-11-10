//
//  WeightDto.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

public struct DtoWeight: Codable {
    var weight: Float
    var date: Date
}

public struct DtoWeightUpdate: Identifiable, Codable {
    public var id: String
    var weight: Float
    var date: Date
}
