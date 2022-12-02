//
//  PetFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension PetForm {
    @MainActor class ViewModel: ObservableObject {
        var id: String?

        @Published var name: String
        @Published var kind: PetKind
        @Published var breed: SelectItem?
        @Published var microchip: String
        @Published var birthDate: Date

        @Published var isLoading = false
        @Published var isError = false
        var isInvalid: Bool {
            self.name == ""
        }
        var errorMessage = ""

        var onSave: () -> Void
        var onDelete: () -> Void

        var breedId: Int? {
            if let id = breed?.id {
                return Int(id)
            }

            return nil
        }

        init(pet: PetDB? = nil, onSave: @escaping () -> Void, onDelete: @escaping () -> Void) {
            self.id = pet?.id
            self.name = pet?.name ?? ""
            self.kind = pet?.kind ?? PetKind.Dog
            if let petBreed = pet?.breed {
                self.breed = SelectItem(label: petBreed.localizedName, id: String(petBreed.id))
            }
            self.microchip = pet?.microchip ?? ""
            self.birthDate = pet?.birthDate ?? Date()

            self.onSave = onSave
            self.onDelete = onDelete
        }

        func create() {
            var payload =  DtoPet(name: self.name, kind: self.kind, microchip: self.microchip, birthDate: self.birthDate, breed: self.breedId)

            WolfieApi().postPets(body: payload) { results in
                switch results {
                case .success:
                    RealmManager().fetchPets()

                    self.onSave()
                case .failure(let error):
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
            var payload =  DtoPetUpdate(
                id: self.id!,
                name: self.name,
                kind: self.kind,
                microchip: self.microchip,
                birthDate: self.birthDate,
                breed: self.breedId
            )

            WolfieApi().putPets(petId: self.id!, body: payload) { results in
                switch results {
                case .success:
                    RealmManager().fetchPets()

                    self.onSave()
                case .failure(let error):
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

        func delete() {
            WolfieApi().deletePets(petId: self.id!) { results in
                switch results {
                case .success:
                    RealmManager().fetchPets()

                    self.onSave()
                case .failure(let error):
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
    }
}
