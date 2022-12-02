//
//  MedicineValueDB.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 16/11/2022.
//

import Foundation
import RealmSwift

class MedicineValueDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var productNumber: String
    @Persisted var name: String
    @Persisted var inn: String?
    @Persisted var activeSubstance: String?
    @Persisted var patientSafety: Bool?
    @Persisted var authorisationStatus: MedicineAuthorizationStatus?
    @Persisted var atcCode: String?
    @Persisted var additionalMonitoring: Bool?
    @Persisted var generic: Bool?
    @Persisted var biosimilar: Bool?
    @Persisted var conditionalApproval: Bool?
    @Persisted var exceptionalCircumstances: Bool?
    @Persisted var acceleratedAssessment: Bool?
    @Persisted var orphanMedicine: Bool?
    @Persisted var marketingAuthorisationDate: Date?
    @Persisted var dateOfRefusalOfMarketingAuthorisation: Date?
    @Persisted var pharmacotherapeuticGroup: String?
    @Persisted var dateOfOpinion: Date?
    @Persisted var decisionDate: Date?
    @Persisted var revisionNumber: Int?
    @Persisted var conditionIndication: String?
    @Persisted var species: String?
    @Persisted var firstPublished: Date?
    @Persisted var revisionDate: Date?
    @Persisted var url: Date?
    @Persisted var createdAt: Date?
    @Persisted var updatedAt: Date?
    
    var localizedName: String {
        let name = self.name
            .replacingOccurrences(of: "[^A-Za-z0-9]", with: "_", options: .regularExpression)
            .lowercased()
        
        return NSLocalizedString("breed_\(name)", comment: "")
    }
    
    static func fromShortApi(data: ApiShortMedicineValue) -> MedicineValueDB {
        let dataDb = MedicineValueDB()
        dataDb.productNumber = data.productNumber
        dataDb.name = data.name
 
        return dataDb
    }
    
    var asShortApi: ApiShortMedicineValue {
        ApiShortMedicineValue(
            productNumber: self.productNumber,
            name: self.name
        )
    }
}
