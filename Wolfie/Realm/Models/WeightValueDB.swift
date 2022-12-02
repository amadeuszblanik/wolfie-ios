//
//  WeightValue.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import RealmSwift

class WeightValueDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var raw: Float
    @Persisted var formatted: String
    @Persisted var rawGram: Float
    @Persisted var date: Date
    @Persisted var createdAt: Date
    @Persisted var updatedAt: Date
    @Persisted var petId: String? = nil
    
    static func fromApi(data: ApiWeightValue, petId: String? = nil) -> WeightValueDB {
        let dataDb = WeightValueDB()
        dataDb.id = data.id
        dataDb.raw = data.raw
        dataDb.formatted = data.formatted
        dataDb.rawGram = data.rawGram
        dataDb.date = data.date
        dataDb.createdAt = data.createdAt
        dataDb.updatedAt = data.updatedAt
        dataDb.petId = petId
        
        return dataDb
    }
    
    var asApi: ApiWeightValue {
        ApiWeightValue(
            id: id,
            raw: raw,
            formatted: formatted,
            rawGram: rawGram,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
