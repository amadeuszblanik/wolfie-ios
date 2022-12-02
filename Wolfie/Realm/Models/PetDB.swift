//
//  Pet.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import RealmSwift

class PetDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var kind: PetKind
    @Persisted var microchip: String?
    @Persisted var image: String
    @Persisted var currentWeight: WeightValueDB?
    @Persisted var birthDate: Date
    @Persisted var healthLog: Int
    @Persisted var breed: BreedDB?
    @Persisted var createdAt: Date
    @Persisted var updatedAt: Date
    
    static func fromApi(data: ApiPetSingle) -> PetDB {
        let dataDb = PetDB()
        dataDb.id = data.id
        dataDb.name = data.name
        dataDb.kind = data.kind
        dataDb.microchip = data.microchip
        dataDb.image = data.image
        if let currentWeight = data.currentWeight {
            dataDb.currentWeight = WeightValueDB.fromApi(data: currentWeight, petId: data.id)
        }
        dataDb.birthDate = data.birthDate
        dataDb.healthLog = data.healthLog
        if let breed = data.breed {
            dataDb.breed = BreedDB.fromApi(data: breed)
        }
        dataDb.createdAt = data.createdAt
        dataDb.updatedAt = data.updatedAt
        
        return dataDb
    }
    
    var asApi: ApiPetSingle {
        ApiPetSingle(
            id: id,
            name: name,
            kind: kind,
            microchip: microchip,
            image: image,
            currentWeight: currentWeight?.asApi,
            birthDate: birthDate,
            healthLog: healthLog,
            breed: breed?.asApi,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
