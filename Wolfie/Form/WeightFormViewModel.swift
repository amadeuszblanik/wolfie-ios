//
//  WeightFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension WeightForm {
    @MainActor class ViewModel: ObservableObject {
        var id: String?
        var pet: PetDB

        @Published var weight: Float = 0
        @Published var date = Date()
        @Published var isLoading = false
        @Published var isError = false
        var weightUnit: WeightUnits = .Kilogram
        var dateRange: ClosedRange<Date> {
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: pet.birthDate)
            let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())

            return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
        }
        var isInvalid: Bool {
            weight <= 0
        }
        var errorMessage = ""
        var onSuccess: () -> Void

        init(pet: PetDB, weight: WeightValueDB? = nil, onSuccess: @escaping () -> Void) {
            self.onSuccess = onSuccess
            self.pet = pet
            self.id = weight?.id
            self.weight = weight?.raw ?? 0.00
            self.date = weight?.date ?? Date()
        }

        func create() {
            self.isLoading = true
            let payload = DtoWeight(weight: self.weight, date: self.date)

            WolfieApi().postPetsWeights(petId: pet.id, body: payload) { result in
                switch result {
                case .success:
                    RealmManager().fetchWeights(petId: self.pet.id)

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

        func update() {
            self.isLoading = true
            let payload = DtoWeight(weight: self.weight, date: self.date)

            WolfieApi().patchPetsWeights(petId: pet.id, weightId: self.id!, body: payload) { result in
                switch result {
                case .success:
                    RealmManager().fetchWeights(petId: self.pet.id)

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
    }
}
