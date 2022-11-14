//
//  WeightFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension WeightForm {
    struct FormState: Equatable {
        var weight: Float = .zero
        var date: Date = Date()
    }
    
    @MainActor class ViewModel: ObservableObject {
        var id: String? = nil
        var pet: PetDB? = nil
        @Published var state = FormState()
        @Published var isLoading = false
        @Published var isError = false
        var weightUnit: WeightUnits = .Kilogram
        var dateRange: ClosedRange<Date> {
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: pet?.birthDate ?? .distantPast)
            let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
    
            return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
        }
        var isInvalid: Bool {
            state.weight <= 0
        }
        var errorMessage = ""
        var onSuccess: () -> Void
        
        init(pet: PetDB, weight: WeightValueDB? = nil, onSuccess: @escaping () -> Void) {
            self.onSuccess = onSuccess
            self.pet = pet
            self.state.weight = weight?.raw ?? .zero
            self.state.date = weight?.date ?? Date()
        }

        func create() {
            self.isLoading = true
            let payload = DtoWeight(weight: self.state.weight, date: self.state.date)
            
            WolfieApi().postPetsWeights(petId: pet?.id ?? "", body: payload) { result in
                switch result {
                case .success:
                    RealmManager().fetchWeights(petId: self.pet?.id ?? "")
                    
                    self.onSuccess()
                case .failure(let error):
                    self.isLoading = false
                    self.isError = true

                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = String(localized: "error_generic_message")
                    }
                }
            }
        }
        
        func update() {
            print("Update \(self.id)\n\(self.state.weight)\n\(self.state.date)")
        }
    }
}
