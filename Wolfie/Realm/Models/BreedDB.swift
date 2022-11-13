//
//  Breed.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import RealmSwift

class BreedDB: Object, ObjectKeyIdentifiable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var group: String
    @Persisted var section: String?
    @Persisted var provisional: String?
    @Persisted var country: String?
    @Persisted var url: String?
    @Persisted var image: String?
    @Persisted var pdf: String?
    @Persisted var createdAt: Date;
    @Persisted var updatedAt: Date;
    
    var localizedName: String {
        let name = self.name
            .replacingOccurrences(of: "[^A-Za-z0-9]", with: "_", options: .regularExpression)
            .lowercased()
        
        return NSLocalizedString("breed_\(name)", comment: "")
    }
    
    static func fromApi(data: ApiBreed) -> BreedDB {
        let dataDb = BreedDB()
        dataDb.id = data.id
        dataDb.name = data.name
        dataDb.group = data.group
        dataDb.section = data.section
        dataDb.provisional = data.provisional
        dataDb.country = data.country
        dataDb.url = data.url
        dataDb.image = data.image
        dataDb.pdf = data.pdf
        dataDb.createdAt = data.createdAt
        dataDb.updatedAt = data.updatedAt
        
        return dataDb
    }
    
    var asApi: ApiBreed {
        ApiBreed(
            id: id,
            name: name,
            group: group,
            section: section,
            provisional: provisional,
            country: country,
            url: url,
            image: image,
            pdf: pdf,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
