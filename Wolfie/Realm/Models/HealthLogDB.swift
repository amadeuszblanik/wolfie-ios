//
//  HealthLogDb.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 16/11/2022.
//

import Foundation
import RealmSwift

class HealthLogDB: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var kind: HealthLogKind
    @Persisted var date: Date
    @Persisted var medicines: RealmSwift.List<MedicineValueDB>
    @Persisted var additionalMedicines: RealmSwift.List<String>
    @Persisted var diagnosis: String?
    @Persisted var nextVisit: Date?
    @Persisted var veterinary: String?
    @Persisted var descriptionValue: String?
    @Persisted var createdAt: Date?
    @Persisted var updatedAt: Date?
    @Persisted var petId: String? = nil
    
    static func fromApi(data: ApiHealthLogValue, petId: String) -> HealthLogDB {
        let medicineList = RealmSwift.List<MedicineValueDB>()
        let additionalMedicineList = RealmSwift.List<String>()
        
        data.medicines.forEach {
            medicineList.append(MedicineValueDB.fromShortApi(data: $0))
        }
        
        data.additionalMedicines.forEach {
            additionalMedicineList.append($0)
        }
        
        let dataDb = HealthLogDB()
        dataDb.id = data.id
        dataDb.kind = data.kind
        dataDb.medicines = medicineList
        dataDb.additionalMedicines = additionalMedicineList
        dataDb.diagnosis = data.diagnosis
        if let nextVisit = data.nextVisit {
            dataDb.nextVisit = nextVisit
        }
        dataDb.veterinary = data.veterinary
        dataDb.descriptionValue = data.description
        dataDb.createdAt = data.createdAt
        dataDb.updatedAt = data.updatedAt
        dataDb.petId = petId
        
        return dataDb
    }
}
