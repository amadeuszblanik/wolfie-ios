//
//  MediciineValue.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

struct ApiShortMedicineValue: Identifiable, Codable {
    var productNumber: String
    var name: String
    
    public var id: String { self.productNumber }
}
