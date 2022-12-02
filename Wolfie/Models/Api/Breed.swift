//
//  Breed.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import Foundation

struct ApiBreed: Identifiable, Codable {
    public var id: Int
    var name: String
    var group: String
    var section: String?
    var provisional: String?
    var country: String?
    var url: String?
    var image: String?
    var pdf: String?
    var createdAt: Date;
    var updatedAt: Date;
    
    var localizedName: String {
        let name = self.name
            .replacingOccurrences(of: "[^A-Za-z0-9]", with: "_", options: .regularExpression)
            .lowercased()
        
        return NSLocalizedString("breed_\(name)", comment: "")
    }
}
