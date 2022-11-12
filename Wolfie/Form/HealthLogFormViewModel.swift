//
//  HealthLogFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation

extension HealthLogForm {
    @MainActor class ViewModel: ObservableObject {
        var pet: ApiPetSingle
        var id: String?
        @Published var kind: HealthLogKind
        @Published var date: Date
        @Published var medicines = Set<String>()
        @Published var additionalMedicines: String
        @Published var veterinary: String
        @Published var diagnosis: String
        @Published var isNextVisit: Bool = false
        @Published var nextVisit: Date
        @Published var description: String
        @Published var medicinesList: [SelectItem] = [SIMPLE_MEDICINE_0].map{ SelectItem(label: $0.name, id: $0.id) }

        init(pet: ApiPetSingle, healthLog: ApiHealthLogValue? = nil) {
            self.pet = pet
            self.id = healthLog?.id
            self.kind = healthLog?.kind ?? .Treatment
            self.date = healthLog?.date.asDate ?? Date()
//            self.medicines = healthLog?.medicine ?? []
            self.additionalMedicines = healthLog?.additionalMedicines.joined(separator: ", ") ?? ""
            self.veterinary = healthLog?.veterinary ?? ""
            self.diagnosis = healthLog?.diagnosis ?? ""
            self.nextVisit = healthLog?.nextVisit ?? Date()
            self.description = healthLog?.description ?? ""
        }

        func create() -> Void {
            print("Create \n\(pet.id)\n\(kind)\n\(date)\n\(medicines)\n\(additionalMedicines)\n\(veterinary)\n\(diagnosis)\n\(nextVisit)\n\(description)")
        }
        
        func update() -> Void {
            print("Update \(id)\n\(pet.id)\n\(kind)\n\(date)\n\(medicines)\n\(additionalMedicines)\n\(veterinary)\n\(diagnosis)\n\(nextVisit)\n\(description)")
        }
    }
}
