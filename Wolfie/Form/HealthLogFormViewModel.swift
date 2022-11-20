//
//  HealthLogFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation

extension HealthLogForm {
    struct FormState: Equatable {
        var kind: HealthLogKind = .Treatment
        var date: Date = Date()
        var medicines: Set<String> = Set()
        var additionalMedicines: String = ""
        var veterinary: String = ""
        var diagnosis: String = ""
        var nextVisit: Date = Date()
        var description: String = ""
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var isNextVisit: Bool = false
        @Published var state = FormState()
        @Published var medicinesList: [SelectItem] = [SIMPLE_MEDICINE_0].map{ SelectItem(label: $0.name, id: $0.id) }
        @Published var isLoading = false
        @Published var isError = false

        var pet: PetDB
        var id: String?
        var onSuccess: () -> Void
        var errorMessage = ""

        init(pet: PetDB, data: HealthLogDB? = nil, onSuccess: @escaping () -> Void) {
            self.pet = pet
            self.onSuccess = onSuccess
            var medicinesSet = Set<String>()
            
            if let data = data {
                data.medicines.forEach { medicineDb in
                    medicinesSet.insert(medicineDb.productNumber)
                }

                self.id = data.id
                self.state.kind = data.kind
                self.state.date = data.date
                self.state.medicines = medicinesSet
                self.state.additionalMedicines = data.additionalMedicines.joined(separator: ", ")
                self.state.veterinary = data.veterinary ?? ""
                self.state.diagnosis = data.diagnosis ?? ""
                if let nextVisit = data.nextVisit {
                    self.isNextVisit = true
                    self.state.nextVisit = nextVisit
                }
                self.state.description = data.descriptionValue ?? ""
            }
        }

        func create() -> Void {
            self.isLoading = true
            let payload = DtoHealthLog(
                kind: state.kind,
                date: state.date.asDtoDateFormatted,
                medicines: Array(state.medicines),
                additionalMedicines: state.additionalMedicines,
                diagnosis: state.diagnosis,
                nextVisit: isNextVisit ? state.nextVisit : nil,
                veterinary: state.veterinary,
                description: state.description
            )
            
            WolfieApi().postPetsHealthLog(petId: pet.id, body: payload) { result in
                switch result {
                case .success:
                    RealmManager().fetchHealthLog(petId: self.pet.id)
                    
                    self.onSuccess()
                case .failure(let error):
                    self.isError = true

                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = String(localized: "error_generic_message")
                    }
                }

                self.isLoading = false
            }
        }
        
        func update() -> Void {
            self.isLoading = true
            let payload = DtoHealthLog(
                kind: state.kind,
                date: state.date.asDtoDateFormatted,
                medicines: Array(state.medicines),
                additionalMedicines: state.additionalMedicines,
                diagnosis: state.diagnosis,
                nextVisit: isNextVisit ? state.nextVisit : nil,
                veterinary: state.veterinary,
                description: state.description
            )
            
            if let id = self.id {
                WolfieApi().patchPetsHealthLog(petId: pet.id, healthLogId: id, body: payload) { result in
                    switch result {
                    case .success:
                        RealmManager().fetchHealthLog(petId: self.pet.id)
                        
                        self.onSuccess()
                    case .failure(let error):
                        self.isError = true
                        
                        switch error {
                        case .server(let message):
                            self.errorMessage = message
                        default:
                            self.errorMessage = String(localized: "error_generic_message")
                        }
                    }
                    
                    self.isLoading = false
                }
            } else {
                self.isLoading = false
                self.isError = true
                self.errorMessage = String(localized: "error_generic_message")
            }
        }
    }
}
